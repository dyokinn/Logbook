import type { NextPage } from 'next'
import ship from '../../public/images/navio.jpg'
import Image from 'next/image'
import NavBar from '../components/home/navBar'
import Card from '../components/home/card'
import { FiAnchor } from "react-icons/fi";
import { useTheme } from '../hooks/useTheme'

const Home: NextPage = () => {
  const {mode, theme, setModeOpt} = useTheme()
  return (
    <>
        <NavBar/>
    </>
  )
}

export default Home
