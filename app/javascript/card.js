const pay = () => {
  if (typeof gon === 'undefined' || !gon.public_key) {
    console.error("Gon public key is not defined.");
    return;
  }
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // カード情報のマウント
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then(function (response) {
      const errorElement = document.getElementById("card-error-messages");
      errorElement.innerHTML = "";
      if (response.error) {
        errorElement.innerHTML = `<li>${response.error.message}</li>`;
      } else {
        const token = response.id;
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        form.submit();
      }
    });
  });
};

document.addEventListener("turbo:load", pay);
document.addEventListener("turbo:render", pay);