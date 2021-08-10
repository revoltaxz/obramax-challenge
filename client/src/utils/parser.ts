export const parseMessages = (message: string) => {
  switch (message) {
    case 'Zip code outside the delivery area for this method':
      return 'Método de envio fora da área de cobertura'
    case 'Minimum price not reached for this method':
      return 'Valor inserido não atinge o minimo para este método de envio.'
    case 'Disabled shipping':
      return 'Método de envio desabilitado.'
    default:
      return ''
  }
}
