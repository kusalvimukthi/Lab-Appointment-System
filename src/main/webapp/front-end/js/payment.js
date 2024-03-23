/* COPY INPUT VALUES TO CARD MOCKUP */
const bounds = document.querySelectorAll("[data-bound]");

for (let i = 0; i < bounds.length; i++) {
  const targetId = bounds[i].getAttribute("data-bound");
  const defValue = bounds[i].getAttribute("data-def");
  const targetEl = document.getElementById(targetId);
  bounds[i].addEventListener(
    "blur",
    () => (targetEl.innerText = bounds[i].value || defValue)
  );
}

/* TOGGLE CVC DISPLAY MODE */
const cvc_toggler = document.getElementById("cvc_toggler");

cvc_toggler.addEventListener("click", () => {
  const target = cvc_toggler.getAttribute("data-target");
  const el = document.getElementById(target);
  el.setAttribute("type", el.type === "text" ? "password" : "text");
});

function onlyNumberKey(evt) {
  // Only ASCII character in that range allowed
  var ASCIICode = evt.which ? evt.which : evt.keyCode;
  if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57)) return false;
  return true;
}

$(function () {
  $("#cardNumber").on("keyup", function (e) {
    var val = $(this).val();
    var newval = "";
    val = val.replace(/\s/g, "");
    for (var i = 0; i < val.length; i++) {
      if (i % 4 == 0 && i > 0) newval = newval.concat(" ");
      newval = newval.concat(val[i]);
    }
    $(this).val(newval);
  });

  $(".year-own").datepicker({
    minViewMode: 2,
    format: "yyyy"
  });

  $(".month-own").datepicker({
    format: "MM",
    minViewMode: "months",
    maxViewMode: "months",
    startView: "months"
  });
});

document.addEventListener('DOMContentLoaded', function() {
    const checkbox = document.getElementById('flexSwitchCheckDefault');
    const hiddenElement = document.querySelector('.hide.hidden-element');
    const payDetails = document.querySelector('.pay.hidden-element');
    const makeAppoinment = document.querySelector('.makeappoinment');

    checkbox.addEventListener('change', function() {
        if (checkbox.checked) {
            hiddenElement.classList.remove('hidden-element');
            payDetails.classList.remove('hidden-element');
            makeAppoinment.classList.add('hidden-element');
        } else {
            hiddenElement.classList.add('hidden-element');
            payDetails.classList.add('hidden-element');
            makeAppoinment.classList.remove('hidden-element');
        }
    });
});

function updateDetails() {
  var dropdown = document.getElementById("medical_test");
  var selectedOption = dropdown.options[dropdown.selectedIndex];
  var testNameElement = document.getElementById("testname");
  var valuesElement = document.getElementById("valuess");

  testNameElement.textContent = selectedOption.textContent;
  
  // Mapping of option values to corresponding values
  var valueMap = {
      "0": 0,
      "1": 400,
      "2": 500,
      "3": 0 
  };

  // Get the corresponding value based on the selected option
  var selectedValue = valueMap[selectedOption.value];

  valuesElement.textContent = selectedValue;
}