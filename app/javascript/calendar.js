import AirDatepicker from 'air-datepicker'

document.addEventListener('turbo:load', () => {
  calendar = document.getElementById('datepicker')

  datetime = calendar.getAttribute("value")

  if (datetime === null) {
    datetime = Date.now()
  }


  new AirDatepicker('#datepicker', {
    timepicker: true,
    timeFormat: 'H:mm',
    selectedDates: [datetime]
  })
})
