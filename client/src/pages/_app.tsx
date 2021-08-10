import type { AppProps /*, AppContext */ } from 'next/app'
import Head from 'next/head'

import GlobalStyles from 'styles/global'

function App({ Component, pageProps }: AppProps) {
  return (
    <>
      <Head>
        <title>Consulta de Frete - Obramax</title>
        <link rel="shortcut icon" href="/img/icon-obramax.png" />
        <link rel="apple-touch-icon" href="/img/icon-obramax.png" />
        <link rel="manifest" href="/manifest.json" />
        <meta name="description" content="Validador de Frete - Obramax" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link
          rel="preconnect"
          href="https://fonts.gstatic.com"
          crossOrigin="true"
        />
        <link
          href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200;0,300;0,400;0,600;0,700;1,400;1,900&display=swap"
          rel="stylesheet"
        />
      </Head>
      <GlobalStyles />
      <Component {...pageProps} />
    </>
  )
}

export default App
