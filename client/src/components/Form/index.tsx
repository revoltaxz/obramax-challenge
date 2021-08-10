import Input from 'components/Input'
import { useForm, Controller } from 'react-hook-form'
import { useState } from 'react'

import { cepMask } from 'utils/masks'
import * as S from './styles'
import { api } from 'utils/api'
import Results from 'components/Results'

const Form = () => {
  const [results, setResults] = useState([])
  const { handleSubmit, control, reset, setError } = useForm()

  const onSubmit = async (data: { cep: string; price: string }) => {
    try {
      const { data: response } = await api.post('/validate', {
        cep: data.cep,
        price: parseInt(data.price)
      })
      setResults(response)
    } catch (err) {
      if (err.response.data.title === 'Invalid cep size') {
        setError('cep', { type: 'focus', message: 'CEP no formato inválido' })
      }
    }
  }

  const onResetValues = () => {
    setResults([])
    reset({ cep: '', price: '' })
  }

  return (
    <S.Wrapper>
      <S.Form onSubmit={handleSubmit(onSubmit)}>
        <h2 className="form-description">
          Insira os dados abaixo para consultar{' '}
        </h2>
        <div className="input-container">
          <label className="input-label" htmlFor="cep">
            CEP
          </label>
          <Controller
            name="cep"
            defaultValue=""
            control={control}
            rules={{ required: 'Campo obrigatório' }}
            render={({ field, fieldState }) => (
              <>
                <Input
                  {...field}
                  type="text"
                  id="cep"
                  error={Boolean(fieldState.error?.message)}
                  maxLength="9"
                  onChange={(event: React.ChangeEvent<HTMLInputElement>) => {
                    field.onChange(cepMask(event.target.value))
                  }}
                />
                {fieldState.error && (
                  <span className="error-label">
                    {fieldState.error.message}
                  </span>
                )}
              </>
            )}
          />
        </div>
        <div className="input-container">
          <label className="input-label" htmlFor="price">
            Valor (em centavos)
          </label>
          <Controller
            name="price"
            defaultValue=""
            control={control}
            rules={{ required: 'Campo obrigatório' }}
            render={({ field, fieldState }) => (
              <>
                <Input
                  {...field}
                  type="text"
                  id="price"
                  error={Boolean(fieldState.error?.message)}
                />
                {fieldState.error && (
                  <span className="error-label">
                    {fieldState.error.message}
                  </span>
                )}
              </>
            )}
          />
        </div>
        <div className="form-footer">
          <button className="btn submit" type="submit">
            Consultar
          </button>
          <button className="btn clear" type="button" onClick={onResetValues}>
            Limpar
          </button>
        </div>
      </S.Form>
      <Results results={results} />
    </S.Wrapper>
  )
}

export default Form
