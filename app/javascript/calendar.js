import AirDatepicker from 'air-datepicker'

document.addEventListener('turbo:load', () => {
  const calendar = document.getElementById('datepicker')
  if (calendar == null) {
    return 0;
  }
  datetime = calendar.value || new Date

  datepicker = new AirDatepicker('#datepicker', {
    timepicker: true,
    timeFormat: 'H:mm',
    selectedDates: [datetime]
  })


  calendar.addEventListener('change', () => {
    const [dateComponents, timeComponents] = calendar.value.split(' ');

    const [day, month, year] = dateComponents.split('.');
    const [hours, minutes] = timeComponents.split(':');

    datetime = new Date(+year, month - 1, +day, +hours, +minutes);

    datepicker.destroy()
    datepicker = new AirDatepicker('#datepicker', {
      timepicker: true,
      timeFormat: 'H:mm',
      selectedDates: [datetime]
    })
  })
})
