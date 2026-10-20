(function () {
    "use strict";

    const canvas = document.getElementById("detailGoogleMap");
    const dataElement = document.getElementById("detailMapData");
    const status = document.getElementById("detailMapStatus");
    const filterButton = document.getElementById("detailMapFilterButton");
    const filterMenu = document.getElementById("detailMapFilterMenu");
    const filterLabel = document.getElementById("detailMapFilterLabel");
    const filterDot = document.getElementById("detailMapFilterDot");
    const legend = document.getElementById("detailMapDayLegend");

    if (!canvas || !dataElement) {
        return;
    }

    const dayLinePalette = ['#7C3AED','#2563EB','#F97316','#10B981','#EC4899','#06B6D4','#EF4444','#6366F1','#14B8A6','#D97706','#8B5CF6','#0EA5E9'];


    let days = [];
    let map = null;
    let markers = [];
    let lines = [];
    let activeDay = "all";
    // 일정표 JS가 지도 JS보다 먼저 실행된다. 초기 시트 변경 이벤트를
    // 놓치지 않도록 활성 탭을 직접 읽는다 (단일 시트는 국가별 DAY 경로 표시).
    const initialSheetTab = document.querySelector("#detailSheetTabs [data-detail-sheet].is-active");
    let activeSheet = initialSheetTab ? initialSheetTab.dataset.detailSheet : "all";
    let placesLibraryPromise = null;
    let infoSequence = 0;
    let selectedBlockId = "";

    const placeDetailsCache = Object.create(null);

    function escapeHtml(value) {
        return String(value == null ? "" : value)
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#39;");
    }

    function showStatus(message) {
        if (!status) {
            return;
        }
        status.textContent = message || "";
        status.hidden = !message;
    }

    function showMapFallback() {
        if (canvas.dataset.fallback === "1") return;
        const root = document.getElementById("scheduleDetail");
        const query = root ? [root.dataset.mapCity, root.dataset.mapCountry].filter(Boolean).join(", ") : "";
        const iframe = document.createElement("iframe");
        iframe.title = "경로 지도";
        iframe.src = "https://maps.google.com/maps?q=" + encodeURIComponent(query || "Seoul, Korea") + "&z=11&output=embed";
        iframe.style.cssText = "width:100%;height:100%;min-height:360px;border:0;display:block";
        iframe.loading = "lazy";
        iframe.referrerPolicy = "no-referrer-when-downgrade";
        canvas.replaceChildren(iframe);
        canvas.dataset.fallback = "1";
        if (legend) legend.hidden = true;
        showStatus("");
    }
    window.detailMapLoadFailed = showMapFallback;

    function dayLineColor(number) {
        let dayNumber = parseInt(number, 10);
        if (!dayNumber || dayNumber < 1) {
            dayNumber = 1;
        }
        return dayLinePalette[(dayNumber - 1) % dayLinePalette.length];
    }

    try {
        const raw = JSON.parse(dataElement.textContent);

        if (!Array.isArray(raw)) {
            throw new Error("지도 데이터 형식이 올바르지 않습니다.");
        }

        days = raw.map(function (day) {
            const points = Array.isArray(day.points) ? day.points : [];

            return {
                number: String(day.dayNumber),
                title: day.title || "",
                sheetKey: String(day.sheetKey || "legacy-1"),
                sheetLabel: String(day.sheetLabel || "일정"),
                sheetIndex: Number(day.sheetIndex) || 1,
                points: points.map(function (point, index) {
                    return {
                        blockId: point.blockId,
                        sequence: Number(point.sequence) || index + 1,
                        type: point.type,
                        title: point.title || point.placeName || "장소",
                        placeName: point.placeName || point.title || "장소",
                        address: point.address || "",
                        googlePlaceId: String(point.googlePlaceId || "").trim(),
                        lat: point.lat === null || point.lat === undefined || point.lat === "" ? null : Number(point.lat),
                        lng: point.lng === null || point.lng === undefined || point.lng === "" ? null : Number(point.lng)
                    };
                }).sort(function (a, b) { return a.sequence - b.sequence; })
            };
        });
    } catch (error) {
        console.error(error);
        showStatus("지도 데이터를 확인해주세요.");
        return;
    }

    function setMenuOpen(open) {
        if (!filterMenu || !filterButton) {
            return;
        }
        filterMenu.hidden = !open;
        filterButton.setAttribute("aria-expanded", String(open));
    }

    function sheetLineColor(index) {
        return dayLinePalette[((Math.max(1, Number(index) || 1) - 1) % dayLinePalette.length)];
    }

    function visibleDays() {
        return days.filter(function (day) {
            return activeSheet === "all" || day.sheetKey === activeSheet;
        });
    }

    function sheetGroups() {
        const groups = [];
        const seen = new Set();
        days.forEach(function (day) {
            if (seen.has(day.sheetKey)) return;
            seen.add(day.sheetKey);
            groups.push({ key: day.sheetKey, label: day.sheetLabel, index: day.sheetIndex });
        });
        // DAY가 없는 시트도 지도 필터에 표시한다.
        const tabList = document.getElementById("detailSheetList");
        if (tabList) {
            tabList.querySelectorAll("[data-detail-sheet]").forEach(function (tab) {
                const key = tab.dataset.detailSheet;
                if (key === "all" || seen.has(key)) return;
                seen.add(key);
                groups.push({ key: key, label: tab.textContent.trim(), index: groups.length + 1 });
            });
        }
        return groups;
    }

    function decorateFilterMenu() {
        if (!filterMenu) return;
        filterMenu.replaceChildren();
        const options = [{ key: "all", label: "전체", color: null }];
        if (activeSheet === "all") {
            sheetGroups().forEach(function (sheet) {
                options.push({ key: "sheet:" + sheet.key, label: sheet.label,
                    color: "#6369D1" });
            });
        } else {
            visibleDays().forEach(function (day) {
                options.push({ key: day.number, label: day.number + "일차",
                    color: dayLineColor(day.number) });
            });
        }
        options.forEach(function (option) {
            const button = document.createElement("button");
            button.type = "button";
            button.dataset.detailMapDay = option.key;
            const label = document.createElement("span");
            label.textContent = option.label;
            button.appendChild(label);
            if (option.color) {
                const swatch = document.createElement("span");
                swatch.className = "detail-map-filter-line";
                swatch.style.background = option.color;
                button.appendChild(swatch);
            }
            filterMenu.appendChild(button);
        });
    }

    function updateFilter() {
        let label = "전체";
        let color = "#6369D1";
        if (activeDay !== "all") {
            if (activeSheet === "all") {
                const group = sheetGroups().find(function (s) { return "sheet:" + s.key === activeDay; });
                if (group) { label = group.label; color = "#6369D1"; }
            } else {
                label = activeDay + "일차";
                color = dayLineColor(activeDay);
            }
        }
        if (filterLabel) filterLabel.textContent = label;
        if (filterDot) filterDot.style.background = color;
        if (filterMenu) filterMenu.querySelectorAll("[data-detail-map-day]").forEach(function (button) {
            button.setAttribute("aria-pressed", String(button.dataset.detailMapDay === activeDay));
        });
    }

    window.addEventListener("detail:sheet-change", function (event) {
        activeSheet = event.detail && event.detail.sheetKey ? String(event.detail.sheetKey) : "all";
        activeDay = "all";
        selectedBlockId = "";
        syncTimeline(); updateNotice();
        setMenuOpen(false);
        decorateFilterMenu();
        updateFilter();
        if (map) drawMap();
    });

    if (filterButton && filterMenu) {
        filterButton.addEventListener("click", function () {
            setMenuOpen(filterMenu.hidden);
        });

        filterMenu.addEventListener("click", function (event) {
            const button = event.target.closest("[data-detail-map-day]");
            if (!button) {
                return;
            }

            activeDay = button.dataset.detailMapDay || "all";
            selectedBlockId = "";
            syncTimeline(); updateNotice();
            setMenuOpen(false);
            updateFilter();

            if (map) {
                drawMap();
            }
        });

        document.addEventListener("click", function (event) {
            if (!filterButton.contains(event.target)
                    && !filterMenu.contains(event.target)) {
                setMenuOpen(false);
            }
        });

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape") {
                setMenuOpen(false);
            }
        });
    }

    function getPlacesLibrary() {
        if (placesLibraryPromise) {
            return placesLibraryPromise;
        }

        if (!window.google || !google.maps
                || typeof google.maps.importLibrary !== "function") {
            return Promise.reject(
                new Error("Google Maps JavaScript API를 불러오지 못했습니다.")
            );
        }

        placesLibraryPromise = google.maps.importLibrary("places");
        return placesLibraryPromise;
    }

    function googleMapsDetailUrl(point) {
        const placeId = point && point.googlePlaceId
            ? String(point.googlePlaceId).trim()
            : "";

        let query = point && point.placeName
            ? String(point.placeName).trim()
            : (point && point.title ? String(point.title).trim() : "");

        if (point && Number.isFinite(Number(point.lat))
                && Number.isFinite(Number(point.lng))) {
            query = (query ? query + " " : "")
                + Number(point.lat) + "," + Number(point.lng);
        }

        let url = "https://www.google.com/maps/search/?api=1";
        if (query) {
            url += "&query=" + encodeURIComponent(query);
        }
        if (placeId) {
            url += "&query_place_id=" + encodeURIComponent(placeId);
        }
        return url;
    }

    function fetchPlaceDetails(point) {
        const placeId = point && point.googlePlaceId
            ? String(point.googlePlaceId).trim()
            : "";

        if (!placeId) {
            return Promise.resolve(null);
        }

        if (placeDetailsCache[placeId]) {
            return placeDetailsCache[placeId];
        }

        placeDetailsCache[placeId] = getPlacesLibrary()
            .then(function (placesLib) {
                if (!placesLib || !placesLib.Place) {
                    return null;
                }

                const place = new placesLib.Place({ id: placeId });
                return place.fetchFields({
                    fields: [
                        "displayName",
                        "formattedAddress",
                        "rating",
                        "userRatingCount",
                        "photos",
                        "googleMapsURI"
                    ]
                }).then(function () {
                    return place;
                });
            })
            .catch(function (error) {
                delete placeDetailsCache[placeId];
                throw error;
            });

        return placeDetailsCache[placeId];
    }

    function placeInfoHtml(point, details, infoId, group) {
        const name = details && details.displayName
            ? details.displayName
            : (point.placeName || point.title || "장소");
        const address = details && details.formattedAddress
            ? details.formattedAddress
            : point.address;
        const rating = details && typeof details.rating === "number"
            ? details.rating
            : null;
        const ratingCount = details
            && typeof details.userRatingCount === "number"
            ? details.userRatingCount
            : null;
        const mapsUrl = details && details.googleMapsURI
            ? details.googleMapsURI
            : googleMapsDetailUrl(point);

        let photoHtml = "";

        if (details && details.photos && details.photos.length) {
            const photo = details.photos[0];
            let photoUrl = "";

            try {
                photoUrl = photo.getURI({
                    maxWidth: 320,
                    maxHeight: 180
                });
            } catch (ignore) {
                photoUrl = "";
            }

            if (photoUrl) {
                let attributionHtml = "";
                const attributions = photo.authorAttributions || [];

                if (attributions.length) {
                    attributionHtml = '<div style="position:absolute;left:8px;bottom:6px;max-width:calc(100% - 16px);padding:2px 5px;border-radius:4px;background:rgba(17,24,39,.72);font-size:9px;line-height:1.3;color:#fff;white-space:nowrap;overflow:hidden;text-overflow:ellipsis">사진: '
                        + attributions.map(function (attr) {
                            const attrName = attr && attr.displayName
                                ? escapeHtml(attr.displayName)
                                : "Google Maps 사용자";

                            if (attr && attr.uri) {
                                return '<a href="' + escapeHtml(attr.uri)
                                    + '" target="_blank" rel="noopener noreferrer" style="color:#fff;text-decoration:underline">'
                                    + attrName + '</a>';
                            }
                            return attrName;
                        }).join(", ")
                        + '</div>';
                }

                photoHtml = '<div style="position:relative;width:260px;height:130px;overflow:hidden;border-radius:9px 9px 0 0;background:#F3F4F6">'
                    + '<img src="' + escapeHtml(photoUrl)
                    + '" alt="' + escapeHtml(name)
                    + ' 사진" style="width:100%;height:100%;display:block;object-fit:cover">'
                    + attributionHtml
                    + '</div>';
            }
        }

        if (!photoHtml) {
            photoHtml = '<div style="width:260px;height:78px;display:flex;align-items:center;justify-content:center;border-radius:9px 9px 0 0;background:#F3F4F6;color:#9CA3AF;font-size:11px">'
                + (details === null && point.googlePlaceId
                    ? "장소 정보를 불러오는 중..."
                    : "등록된 사진이 없습니다.")
                + '</div>';
        }

        let ratingHtml = "";
        if (rating !== null) {
            ratingHtml = '<div style="margin-top:8px;display:flex;align-items:center;gap:5px;font-size:12px;color:#374151">'
                + '<span style="color:#F59E0B">★</span>'
                + '<strong>' + escapeHtml(rating.toFixed(1)) + '</strong>'
                + (ratingCount !== null
                    ? '<span style="color:#6B7280">평가 '
                        + escapeHtml(Number(ratingCount).toLocaleString())
                        + '개</span>'
                    : "")
                + '</div>';
        } else if (details) {
            ratingHtml = '<div style="margin-top:8px;font-size:11px;color:#9CA3AF">평점 정보 없음</div>';
        }

        return '<div id="' + escapeHtml(infoId)
            + '" style="width:260px;font-family:Arial,\'Noto Sans KR\',sans-serif">'
            + photoHtml
            + '<div style="padding:11px 12px 12px">'
            + '<div style="font-size:14px;line-height:1.35;font-weight:700;color:#111827">'
            + escapeHtml(name || "장소") + '</div>'
            + (address
                ? '<div style="margin-top:5px;font-size:11px;line-height:1.45;color:#6B7280">'
                    + escapeHtml(address) + '</div>'
                : "")
            + ratingHtml
            + '<a href="' + escapeHtml(mapsUrl)
            + '" target="_blank" rel="noopener noreferrer" style="display:inline-flex;margin-top:10px;align-items:center;font-size:12px;font-weight:700;color:#4F46E5;text-decoration:none">구글맵에서 자세히 보기 ↗</a>'
            + '</div>'
            + (group ? visitsHtml(group) : '')
            + '</div>';
    }

    // Keep every block in its original order; only located blocks become map pins.
    function located(point) {
        return point.lat !== null && point.lat !== undefined && point.lat !== ""
            && point.lng !== null && point.lng !== undefined && point.lng !== ""
            && Number.isFinite(Number(point.lat)) && Number.isFinite(Number(point.lng))
            && Math.abs(Number(point.lat)) <= 90 && Math.abs(Number(point.lng)) <= 180;
    }

    function placeKey(point) {
        return point.googlePlaceId ? "place:" + point.googlePlaceId
            : "coord:" + Number(point.lat).toFixed(5) + "," + Number(point.lng).toFixed(5);
    }

    function shownDays() {
        return visibleDays().filter(function (day) {
            return activeDay === "all" || (activeSheet === "all"
                ? activeDay === "sheet:" + day.sheetKey : activeDay === day.number);
        });
    }

    function findBlock(id) {
        for (const day of days) {
            const point = day.points.find(function (p) { return String(p.blockId) === String(id); });
            if (point) return { day: day, point: point };
        }
        return null;
    }

    function syncTimeline() {
        document.querySelectorAll("[data-detail-block]").forEach(function (row) {
            const found = findBlock(row.dataset.detailBlock);
            const missing = !found || !located(found.point);
            row.classList.toggle("is-location-missing", missing);
            row.classList.toggle("is-map-selected", String(row.dataset.detailBlock) === selectedBlockId);
            if (found) row.style.setProperty("--detail-day-color", dayLineColor(found.day.number));
            const badge = row.querySelector(".detail-location-missing");
            if (badge) badge.hidden = !missing;
            const button = row.querySelector("[data-detail-block-select]");
            if (button) {
                button.setAttribute("aria-pressed", String(String(row.dataset.detailBlock) === selectedBlockId));
                button.title = missing ? "위치가 등록되지 않은 일정입니다." : "지도에서 이 일정의 구간 강조";
            }
        });
    }

    function updateNotice() {
        const missing = shownDays().reduce(function (total, day) {
            return total + day.points.filter(function (p) { return !located(p); }).length;
        }, 0);
        const note = document.getElementById("detailMapMissing");
        const clear = document.getElementById("detailMapSelectionClear");
        const wrap = document.getElementById("detailMapNotice");
        if (note) { note.textContent = "위치 없는 일정 " + missing + "개 · 누락 구간은 점선"; note.hidden = !missing; }
        if (clear) clear.hidden = !selectedBlockId;
        if (wrap) wrap.hidden = !missing && !selectedBlockId;
    }

    function selectBlock(id, focusMap) {
        const found = findBlock(id);
        if (!found) return;
        let redraw = false;
        if (activeSheet !== "all" && activeSheet !== found.day.sheetKey) {
            const tab = Array.from(document.querySelectorAll("#detailSheetTabs [data-detail-sheet]"))
                .find(function (el) { return el.dataset.detailSheet === found.day.sheetKey; });
            if (tab) tab.click();
            else activeSheet = found.day.sheetKey;
            redraw = true;
        }
        if (activeDay !== "all" && !shownDays().includes(found.day)) {
            activeDay = activeSheet === "all" ? "sheet:" + found.day.sheetKey : found.day.number;
            redraw = true;
        }
        selectedBlockId = String(id);
        if (redraw && map) { updateFilter(); drawMap(false); }
        else applySelection();
        syncTimeline();
        updateNotice();
        const row = Array.from(document.querySelectorAll("[data-detail-block]"))
            .find(function (el) { return el.dataset.detailBlock === String(id); });
        if (row) {
            const body = row.closest(".detail-day-body");
            if (body && body.hidden) {
                body.hidden = false;
                const toggle = body.parentElement.querySelector("[data-detail-day-toggle]");
                if (toggle) toggle.setAttribute("aria-expanded", "true");
            }
            if (!focusMap) row.scrollIntoView({ behavior: "smooth", block: "nearest" });
        }
        if (map && focusMap && located(found.point)) {
            map.panTo({ lat: found.point.lat, lng: found.point.lng });
        }
    }

    document.addEventListener("click", function (event) {
        const button = event.target.closest("[data-detail-block-select], [data-detail-map-block]");
        if (!button) return;
        const inTimeline = button.hasAttribute("data-detail-block-select");
        selectBlock(inTimeline ? button.dataset.detailBlockSelect : button.dataset.detailMapBlock, inTimeline);
    });
    const clearButton = document.getElementById("detailMapSelectionClear");
    if (clearButton) clearButton.addEventListener("click", function () {
        selectedBlockId = ""; applySelection(); syncTimeline(); updateNotice();
    });

    function clearMap() {
        markers.forEach(function (marker) {
            if (marker.__detailInfoWindow) marker.__detailInfoWindow.close();
            marker.setMap(null);
        });
        lines.forEach(function (line) { line.setMap(null); });
        markers = []; lines = [];
    }

    function markerIcon(group, selected) {
        // Separate number cells prevent repeated visits (1, 9) looking like 19.
        const cellWidths = group.points.map(function (p) {
            return Math.max(30, String(p.sequence).length * 8 + 20);
        });
        const width = cellWidths.reduce(function (sum, value) { return sum + value; }, 0) + 4;
        const center = width / 2;
        const outline = selected ? "#FFD447" : "#fff";
        let cursor = 2;
        const numbers = group.points.map(function (p, index) {
            const x = cursor + cellWidths[index] / 2;
            const divider = index ? '<path d="M' + cursor + ',9 V25" stroke="#fff" stroke-opacity=".85" stroke-width="1.5"/>' : "";
            cursor += cellWidths[index];
            return divider + '<text x="' + x + '" y="17" text-anchor="middle" dominant-baseline="central" fill="#fff" font-family="Arial,sans-serif" font-size="13" font-weight="700">'
                + escapeHtml(p.sequence) + '</text>';
        }).join("");
        const svg = '<svg xmlns="http://www.w3.org/2000/svg" width="' + width + '" height="46" viewBox="0 0 '
            + width + ' 46"><path d="M' + (center - 6) + ',31 L' + center + ',42 L' + (center + 6)
            + ',31" fill="' + group.color + '" stroke="' + outline + '" stroke-width="2"/>'
            + '<rect x="2" y="2" width="' + (width - 4) + '" height="30" rx="15" fill="'
            + group.color + '" stroke="' + outline + '" stroke-width="' + (selected ? 4 : 2) + '"/>'
            + numbers + '</svg>';
        return { url: "data:image/svg+xml;charset=UTF-8," + encodeURIComponent(svg),
            scaledSize: new google.maps.Size(width, 46),
            anchor: new google.maps.Point(center - (group.pixelOffset || 0), 43) };
    }

    function visitsHtml(group) {
        return '<div class="detail-map-visits"><strong>D' + escapeHtml(group.day.number)
            + (group.points.length > 1 ? ' · 같은 장소 방문 ' + group.points.length + '회' : ' · 일정')
            + '</strong>' + group.points.map(function (p) {
                return '<button type="button" data-detail-map-block="' + escapeHtml(p.blockId)
                    + '" aria-pressed="' + String(String(p.blockId) === selectedBlockId) + '">'
                    + escapeHtml(p.sequence) + '. ' + escapeHtml(p.title || p.placeName || "장소") + '</button>';
            }).join("") + '</div>';
    }

    function addMarker(group, bounds) {
        const point = group.points[0];
        const sequences = group.points.map(function (p) { return p.sequence; }).join("·");
        const marker = new google.maps.Marker({
            map: map, position: { lat: point.lat, lng: point.lng },
            title: "D" + group.day.number + " · " + sequences + " · " + (point.placeName || point.title),
            icon: markerIcon(group, false), zIndex: 100 + Number(group.day.number)
        });
        marker.__group = group;
        const infoId = "detail-map-info-" + (++infoSequence);
        const infoWindow = new google.maps.InfoWindow({
            content: placeInfoHtml(point, null, infoId, group), disableAutoPan: true
        });
        marker.__detailInfoWindow = infoWindow;
        let closeTimer = null, markerHovered = false, infoHovered = false;
        function cancelClose() { if (closeTimer) { clearTimeout(closeTimer); closeTimer = null; } }
        function scheduleClose() {
            cancelClose();
            closeTimer = setTimeout(function () { if (!markerHovered && !infoHovered) infoWindow.close(); }, 240);
        }
        infoWindow.addListener("domready", function () {
            const root = document.getElementById(infoId);
            const container = root && root.parentElement;
            if (!container || container.dataset.detailHoverBound === "1") return;
            container.dataset.detailHoverBound = "1";
            container.addEventListener("mouseenter", function () { infoHovered = true; cancelClose(); });
            container.addEventListener("mouseleave", function () { infoHovered = false; scheduleClose(); });
        });
        infoWindow.addListener("closeclick", function () { markerHovered = false; infoHovered = false; cancelClose(); });
        function openInfo() {
            markers.forEach(function (other) { if (other !== marker) other.__detailInfoWindow.close(); });
            infoWindow.setContent(placeInfoHtml(point, null, infoId, group));
            infoWindow.open(map, marker);
            fetchPlaceDetails(point).then(function (details) {
                if (markerHovered || infoHovered) infoWindow.setContent(placeInfoHtml(point, details || false, infoId, group));
            }).catch(function (error) {
                console.warn("지도 핀 상세정보 조회 실패:", error);
                if (markerHovered || infoHovered) infoWindow.setContent(placeInfoHtml(point, false, infoId, group));
            });
        }
        marker.addListener("mouseover", function () { markerHovered = true; cancelClose(); openInfo(); });
        marker.addListener("mouseout", function () { markerHovered = false; scheduleClose(); });
        marker.addListener("click", function () {
            markerHovered = true; cancelClose();
            if (group.points.length === 1) selectBlock(point.blockId, false);
            openInfo();
        });
        markers.push(marker);
        bounds.extend(marker.getPosition());
    }

    // Web-Mercator gives parallel, constant-pixel offsets; it never routes along roads.
    function world(point) {
        const sine = Math.max(-0.9999, Math.min(0.9999, Math.sin(point.lat * Math.PI / 180)));
        return { x: (point.lng + 180) / 360 * 256,
            y: (0.5 - Math.log((1 + sine) / (1 - sine)) / (4 * Math.PI)) * 256 };
    }
    function shiftedPath(edge) {
        const a = { lat: edge.from.lat, lng: edge.from.lng }, b = { lat: edge.to.lat, lng: edge.to.lng };
        if (!edge.offset) return [a, b];
        const pa = world(a), pb = world(b);
        let dx = pb.x - pa.x;
        if (dx > 128) dx -= 256;
        if (dx < -128) dx += 256;
        const dy = pb.y - pa.y, length = Math.hypot(dx, dy);
        if (!length) return [a, b];
        const scale = Math.pow(2, map.getZoom() || 11);
        const canonical = edge.fromKey < edge.toKey ? 1 : -1;
        const amount = edge.offset * canonical / scale;
        const ox = -dy / length * amount, oy = dx / length * amount;
        function inverse(p) {
            const x = p.x + ox, y = p.y + oy;
            return { lat: (2 * Math.atan(Math.exp((0.5 - y / 256) * 2 * Math.PI)) - Math.PI / 2) * 180 / Math.PI,
                lng: ((x / 256 * 360) % 360 + 360) % 360 - 180 };
        }
        return [inverse(pa), inverse({ x: pa.x + dx, y: pb.y })];
    }
    function routeStyle(edge, selected, faded) {
        const opacity = faded ? 0.2 : 0.9;
        const weight = selected ? 6 : 3;
        const arrow = { path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW, scale: selected ? 3 : 2.3,
            fillColor: edge.color, fillOpacity: opacity, strokeColor: edge.color, strokeOpacity: opacity, strokeWeight: 1 };
        const icons = [];
        if (edge.missing) icons.push({ icon: { path: "M 0,-1 0,1", strokeColor: edge.color,
            strokeOpacity: opacity, strokeWeight: weight, scale: 2 }, offset: "0", repeat: "11px" });
        icons.push({ icon: arrow, offset: "55%", repeat: "110px" });
        return { strokeColor: edge.color, strokeOpacity: edge.missing ? 0 : opacity,
            strokeWeight: weight, icons: icons, zIndex: selected ? 20 : 5 };
    }
    function addLine(edge) {
        const line = new google.maps.Polyline(Object.assign({ map: map, path: shiftedPath(edge),
            geodesic: false }, routeStyle(edge, false, false)));
        line.__edge = edge;
        lines.push(line);
    }
    function refreshLinePaths() {
        lines.forEach(function (line) { line.setPath(shiftedPath(line.__edge)); });
    }

    function applySelection() {
        const found = selectedBlockId ? findBlock(selectedBlockId) : null;
        const selectable = found && located(found.point);
        let chosen = selectable ? lines.filter(function (line) {
            return String(line.__edge.to.blockId) === selectedBlockId;
        }) : [];
        const outgoing = !!selectable && !chosen.length;
        if (outgoing) chosen = lines.filter(function (line) {
            return String(line.__edge.from.blockId) === selectedBlockId;
        });
        lines.forEach(function (line) {
            const selected = chosen.includes(line);
            line.setOptions(routeStyle(line.__edge, selected, !!selectable && !selected));
        });
        markers.forEach(function (marker) {
            const selected = selectable && marker.__group.points.some(function (p) { return String(p.blockId) === selectedBlockId; });
            marker.setIcon(markerIcon(marker.__group, !!selected));
            marker.setOpacity(selectable && !selected ? 0.55 : 1);
            marker.setZIndex(selected ? 1000 : 100 + Number(marker.__group.day.number));
        });
        if (!found) showStatus("");
        else if (!located(found.point)) showStatus("D" + found.day.number + " · " + found.point.sequence + " 위치 미등록 — 지도에 표시할 수 없습니다.");
        else {
            const dashed = chosen.some(function (line) { return line.__edge.missing; });
            showStatus("D" + found.day.number + " · " + found.point.sequence + " " + (chosen.length
                ? (dashed ? "중간 위치가 빠진 점선 구간을 강조했습니다." : (outgoing
                    ? "이 일정에서 다음 일정으로 나가는 직선 구간을 강조했습니다."
                    : "이 일정으로 들어오는 직선 구간을 강조했습니다."))
                : "이 일정에 연결된 이동 구간이 없습니다."));
        }
    }

    function updateLegend() {
        if (!legend) return;
        legend.replaceChildren();
        const selectedDays = shownDays();
        selectedDays.forEach(function (day) {
            const row = document.createElement("div"), label = document.createElement("span"), swatch = document.createElement("span");
            label.textContent = (activeSheet === "all" ? day.sheetLabel + " · " : "") + "D" + day.number;
            label.className = "detail-map-day-legend-label";
            swatch.className = "detail-map-day-legend-line";
            swatch.style.background = dayLineColor(day.number);
            row.appendChild(label); row.appendChild(swatch); legend.appendChild(row);
        });
        const key = document.createElement("div");
        key.className = "detail-map-route-key";
        key.textContent = "화살표: 이동 방향 · 점선: 중간 위치 미등록";
        legend.appendChild(key);
        legend.hidden = !selectedDays.length;
    }

    function drawMap(fitView) {
        clearMap();
        const bounds = new google.maps.LatLngBounds(), groups = [], edges = [];
        shownDays().forEach(function (day) {
            const points = day.points.filter(located);
            const grouped = new Map();
            const color = dayLineColor(day.number);
            points.forEach(function (point) {
                const key = placeKey(point);
                if (!grouped.has(key)) {
                    const group = { key: key, day: day, color: color, points: [] };
                    grouped.set(key, group); groups.push(group);
                }
                grouped.get(key).points.push(point);
            });
            const pairs = new Map();
            for (let i = 1; i < points.length; i++) {
                const from = points[i - 1], to = points[i], fromKey = placeKey(from), toKey = placeKey(to);
                if (fromKey === toKey) continue;
                const edge = { from: from, to: to, fromKey: fromKey, toKey: toKey, color: color,
                    missing: Number(to.sequence) - Number(from.sequence) > 1, offset: 0 };
                const key = [fromKey, toKey].sort().join("|");
                if (!pairs.has(key)) pairs.set(key, []);
                pairs.get(key).push(edge); edges.push(edge);
            }
            pairs.forEach(function (pair) {
                if (pair.length > 1) pair.forEach(function (edge, index) { edge.offset = (index - (pair.length - 1) / 2) * 12; });
            });
        });
        // Coincident locations on different days retain each day's color and separate their labels.
        const overlaps = new Map();
        groups.forEach(function (group) {
            const p = group.points[0], key = p.lat.toFixed(5) + "," + p.lng.toFixed(5);
            if (!overlaps.has(key)) overlaps.set(key, []);
            overlaps.get(key).push(group);
        });
        overlaps.forEach(function (list) {
            if (list.length > 1) list.forEach(function (group, index) { group.pixelOffset = (index - (list.length - 1) / 2) * 46; });
        });
        groups.forEach(function (group) { addMarker(group, bounds); });
        edges.forEach(addLine);
        updateLegend(); updateNotice(); syncTimeline(); applySelection();
        if (!groups.length) { showStatus("표시할 장소 좌표가 없습니다. 위치 미등록 일정을 확인해주세요."); return; }
        if (fitView === false) return;
        if (groups.length === 1) { map.setCenter(markers[0].getPosition()); map.setZoom(15); }
        else map.fitBounds(bounds);
    }

    window.initScheduleDetailMap = function () {
        if (map) {
            return;
        }

        try {
            if (canvas.dataset.fallback === "1") canvas.replaceChildren();
            canvas.dataset.fallback = "0";
            map = new google.maps.Map(canvas, {
                center: { lat: 37.5665, lng: 126.9780 },
                zoom: 11,
                gestureHandling: "greedy",
                mapTypeControl: false,
                streetViewControl: false,
                fullscreenControl: false,
                styles: [
                    { featureType: "poi", elementType: "labels", stylers: [{ visibility: "off" }] },
                    { featureType: "transit", elementType: "labels", stylers: [{ visibility: "off" }] }
                ]
            });

            map.addListener("zoom_changed", refreshLinePaths);
            decorateFilterMenu();
            updateFilter();
            drawMap();
        } catch (error) {
            console.error(error);
            window.detailMapLoadFailed();
        }
    };

    syncTimeline();
    updateNotice();
    decorateFilterMenu();
    updateFilter();
    window.setTimeout(function () { if (!map) showMapFallback(); }, 1800);

    // 다른 공통 코드에서 이미 지도를 로딩한 경우
    if (window.google && window.google.maps && window.google.maps.Map) {
        window.initScheduleDetailMap();
    }
})();
