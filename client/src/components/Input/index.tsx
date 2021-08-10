/* eslint-disable @typescript-eslint/no-explicit-any */
import { forwardRef } from 'react'

import * as S from './styles'

const Input = forwardRef<unknown, any>(({ name, error, ...props }, ref) => (
  <S.Input ref={ref} name={name} error={!!error} {...props} />
))

Input.displayName = 'Input'

export default Input
