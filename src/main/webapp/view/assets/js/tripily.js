(function(){
  const qs=(s,r=document)=>r.querySelector(s), qsa=(s,r=document)=>[...r.querySelectorAll(s)];
  window.tripilyToast=function(msg){let t=qs('#tripilyToast');if(!t){t=document.createElement('div');t.id='tripilyToast';t.className='toast';document.body.appendChild(t)}t.textContent=msg;t.classList.add('show');clearTimeout(window.__tripilyToastTimer);window.__tripilyToastTimer=setTimeout(()=>t.classList.remove('show'),2200)};
  window.tripilyDemoSubmit=function(e,msg){if(e)e.preventDefault();tripilyToast(msg||'샘플 화면입니다. Controller 연결 후 실제 처리됩니다.');return false};
  window.openModal=function(id){const el=document.getElementById(id);if(el)el.classList.add('open')};
  window.closeModal=function(id){const el=document.getElementById(id);if(el)el.classList.remove('open')};
  document.addEventListener('click',e=>{
    const open=e.target.closest('[data-modal-open]'); if(open){openModal(open.dataset.modalOpen);return}
    const close=e.target.closest('[data-modal-close]'); if(close){closeModal(close.dataset.modalClose);return}
    const sw=e.target.closest('.switch'); if(sw){sw.classList.toggle('on');sw.setAttribute('aria-checked',sw.classList.contains('on'));return}
    const fq=e.target.closest('.faq-q'); if(fq){fq.parentElement.classList.toggle('open');return}
    const tab=e.target.closest('[data-tab]'); if(tab){const group=tab.dataset.tabGroup||'default';qsa(`[data-tab-group="${group}"]`).forEach(x=>x.classList.remove('active'));tab.classList.add('active');const target=tab.dataset.tab;qsa(`[data-tab-panel-group="${group}"]`).forEach(x=>x.classList.add('hidden'));const p=qs(`[data-tab-panel="${target}"]`);if(p)p.classList.remove('hidden');return}
    const confirmBtn=e.target.closest('[data-confirm]'); if(confirmBtn && !confirm(confirmBtn.dataset.confirm)) e.preventDefault();
  });
  document.addEventListener('change',e=>{
    const input=e.target.closest('[data-image-preview]');if(input&&input.files&&input.files[0]){const img=document.getElementById(input.dataset.imagePreview);if(img){img.src=URL.createObjectURL(input.files[0]);img.classList.remove('hidden')}}
  });
  qsa('[data-demo-duplicate]').forEach(btn=>btn.addEventListener('click',()=>{const field=document.getElementById(btn.dataset.demoDuplicate);if(!field||!field.value.trim())return tripilyToast('값을 먼저 입력해주세요.');tripilyToast('사용 가능한 값입니다.')}));
  qsa('[data-signup-form]').forEach(form=>form.addEventListener('submit',function(e){
    e.preventDefault(); let ok=true; qsa('[data-required]',form).forEach(el=>{const wrap=el.closest('.field')||el.parentElement;let err=wrap.querySelector('.error-text');if(!el.value.trim()){ok=false;if(!err){err=document.createElement('p');err.className='error-text';wrap.appendChild(err)}err.textContent='필수 항목입니다.'}else if(err)err.remove()});
    const pw=qs('#password',form), pc=qs('#passwordConfirm',form); if(pw&&pc&&pw.value!==pc.value){ok=false;tripilyToast('비밀번호 확인이 일치하지 않습니다.');}
    if(ok)tripilyToast('입력 검증 완료! 회원가입 Controller에 연결하면 됩니다.');
  }));
})();