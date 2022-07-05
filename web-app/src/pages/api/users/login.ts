import type { NextApiRequest, NextApiResponse } from 'next'
import prisma  from '../../../services/lib/prisma';

export default async function handler(
    req: NextApiRequest,
    res: NextApiResponse
) {
    const {
        key,      
    } = req.query

    try {
        const result = await prisma.user.findFirst(
            {
                where: {
                    googleId: key.toString()
                }
            }
        )
        res.status(200).json(result)

    } catch (error) {
        res.status(404).json({"error": "User does not exist"})
    }

}
