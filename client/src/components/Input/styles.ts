import styled from 'styled-components'

interface Props {
  error: boolean
}

export const Input = styled.input<Props>`
  padding: 1rem;
  border: 2px solid ${({ error }) => (error ? 'red' : '#a7a7a7')};
  border-radius: 4px;
  font-size: 16px;

  &:hover,
  &:focus,
  &:focus-visible {
    border: 2px solid #ef7f00;
  }
`
