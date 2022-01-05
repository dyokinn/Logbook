import type { NextPage } from 'next'
import ship from '../../public/images/navio.jpg'
import Image from 'next/image'
import NavBar from '../components/home/navBar'
import Card from '../components/home/card'
import { FiAnchor, FiMap } from "react-icons/fi";
import { useTheme } from '../hooks/useTheme'
import styles from "../styles/index.module.scss"
import styled from 'styled-components'
import { StyledButton } from '../components/mui-styled/buttons'

const Background = styled.div<{color: string}>`
    background-color: ${props => props.color};
    margin: 0 !important;
    padding: 0 !important;
    font-family: 'Poppins', sans-serif;
`

const Home: NextPage = () => {
  const {mode, theme, setModeOpt} = useTheme()
  
  return (
    <Background color={theme.second}>
        <NavBar/>
        <div id={styles.welcome}>
            <div>
                <h1 style={{color: `{theme}`}}>Permita-nos acompanhar sua viagem!</h1>
                <p>Guarde suas ações, emoções, relatos e histórico em uma só plataforma</p>
                <StyledButton backgroundColor={theme.blue} textColor={theme.text} endIcon={<FiMap/>}>
                    Comece a navegar!
                </StyledButton>
            </div>
            <div>

            </div>
        </div>
    </Background>
  )
}

export default Home
