import { Props } from './types'
import * as S from './styles'
import { parseMessages } from 'utils/parser'

const ResultCard = ({ result }: Props) => {
  return (
    <S.Container>
      <div className="card-title">
        <h3>{result.method}</h3>
        <S.Badge valid={result.valid}>
          {result.valid ? 'Válido' : 'Inválido'}
        </S.Badge>
      </div>
      <hr />
      <div className="card-content">
        <h3>Inconsistências/Incompatibilidades</h3>
        {result.incompatibilities.length > 0 ? (
          <ul className="incompatibilities-list">
            {result.incompatibilities.map((incompatibility) => (
              <li key={incompatibility}>{parseMessages(incompatibility)}</li>
            ))}
          </ul>
        ) : (
          <span>Não há inconsistências com esse método.</span>
        )}
      </div>
    </S.Container>
  )
}

export default ResultCard
