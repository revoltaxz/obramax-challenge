import styled from 'styled-components'

export const Wrapper = styled.main`
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  gap: 3rem;
  justify-content: center;
  align-items: center;

  .form-description {
    color: #ef7f00;
    text-align: center;
  }

  .form-footer {
    display: flex;
    gap: 1.5rem;
  }

  .input-container {
    display: flex;
    flex-direction: column;
    margin: 2rem 0;
    width: 100%;
  }

  .input-label {
    font-size: 16px;
    font-weight: 700;
  }

  .error-label {
    color: red;
    margin: 8px 0;
  }

  .btn {
    background-color: #fff;
    padding: 1rem;
    font-size: 16px;
    text-transform: uppercase;
    cursor: pointer;
    margin-top: 2rem;
    border-radius: 4px;
    font-weight: bold;

    &.submit {
      border: 3px solid #000;

      &:hover {
        border: 3px solid #ef7f00;
        color: #ef7f00;
      }
    }

    &.clear {
      border: 3px solid #a7a7a7;
      color: #a7a7a7;

      &:hover {
        border: 3px solid #002a5b;
        color: #002a5b;
      }
    }
  }
`

export const Form = styled.form`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
`
