const updatePriceCalculations = () => {
  const priceInput = document.getElementById('item-price');
  const feeDisplay = document.getElementById('fee');
  const profitDisplay = document.getElementById('profit');

  priceInput.addEventListener('input', function() {
    const price = parseInt(priceInput.value, 10);

    if (!isNaN(price) && price >= 300 && price <= 9999999) {
      const fee = Math.floor(price * 0.1);
      const profit = Math.floor(price - fee);

      feeDisplay.textContent = `${fee}`;
      profitDisplay.textContent = `${profit}`;
    } else {
      feeDisplay.textContent = '0';
      profitDisplay.textContent = '0';
    }
  });

  priceInput.dispatchEvent(new Event('input'));
};

window.addEventListener("turbo:load", updatePriceCalculations);
window.addEventListener("turbo:render", updatePriceCalculations);