import styled from 'styled-components'

interface BadgeProps {
  valid: boolean
}

export const Container = styled.div`
  font-family: 'Nunito', sans-serif;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 5px 5px 30px 7px rgba(0, 0, 0, 0.05),
    -5px -5px 30px 7px rgba(0, 0, 0, 0.1);

  .card-title {
    display: flex;
    flex-wrap: nowrap;
    gap: 2rem;
    padding: 1.5rem;
    align-items: center;
  }

  .card-content {
    padding: 1.5rem;
  }

  .incompatibilities-list {
    width: 100%;
    padding: 1rem 4rem;
  }
`

export const Badge = styled.span<BadgeProps>`
  width: 70px;
  background-color: ${({ valid }) => (valid ? 'green' : 'red')};
  color: #fff;
  padding: 8px 16px;
  font-size: 14px;
  display: flex;
  justify-content: center;
  font-weight: bold;
  border-radius: 40px;
`
