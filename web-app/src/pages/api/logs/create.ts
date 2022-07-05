import type { NextApiRequest, NextApiResponse } from 'next'
import prisma  from '../../../services/lib/prisma';

export default async function handler(
    req: NextApiRequest,
    res: NextApiResponse
) {
    const {
        title,
        comments,     
        mental,
        physical,     
        professional,
        social,       
        lat,          
        long,         
        userId      
    } = req.body

    try {
        const result = await prisma.log.create(
            {
                data: req.body
            }
        )
        res.status(200).json(result)

    } catch (error) {
        res.status(500).json({"error": "Error during creation"})
    }

}
