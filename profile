import React from 'react'
import { makeStyles, Theme, createStyles } from '@material-ui/core/styles'
import { Box } from '@material-ui/core'
import MenuAppBar from '../Menu/AppBar'
import { Typography } from '@material-ui/core'
import CircularProgress from '@material-ui/core/CircularProgress';
import { useEffect } from 'react'
import { queryFirebase } from '../../common/FirebaseHelper'
import { useState } from 'react'
import { Paper } from '@material-ui/core'
import { MyInformation } from '../../common/Routes'
import { Link } from 'react-router-dom'


export const useStyles = makeStyles((theme: Theme) =>
    createStyles({
        root: {
            width: "100vw",
            position: "absolute",
            top: 0, bottom: 0, right: 0, left: 0,
        },
        profile_title: { fontSize: "1rem", padding: "10px 0px" },
        hr_line: { background: "#EAEAEA", height: "1px" },
        progressAlign: {
            transform: 'translate(-50%,-50%)',
            position: 'fixed',
            top: "50%",
            left: "50%",
            transition: theme.transitions.create('transform'),
        },
    }))


const Profile = () => {
    const classes = useStyles();
    const [bgColor, setBgColor] = useState<string>("")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const [colorPrimary, setColorPrimary] = useState<string>("")
    const [colorTitle, setColorTitle] = useState<string>("")

    useEffect(() => {
        const getData = async () => {
            try {
                const restaurantName = localStorage.getItem("restaurantName") ?? "";
                const firebaseQuery = await queryFirebase(restaurantName);
                const arraydata = await firebaseQuery.docs;
                const restColors = arraydata.find(doc => doc.id === 'colors')?.data();
                if (restColors) {
                    const { primary, background, title } = restColors;
                    setBgColor(background);
                    setColorPrimary(primary);
                    setColorTitle(title);
                }
            } catch (error) {
                throw new Error('error');
            }
        }
        getData();
    }, [])
    return (
        <>
            <Box className={classes.root} style={{ backgroundColor: `${bgColor}` }}>
                <MenuAppBar showFilter={true} />
                <Box>
                    {bgColor.length ? (
                        <Box>
                            <Box my={1} px={2}>
                                <Typography variant="h5" style={{ color: `${colorTitle}`, fontWeight: 900 }}>Profile</Typography>
                            </Box>
                            <Box position="relative" top={15} px={2}>
                                <Paper elevation={5} style={{ borderRadius: "12px", padding: "5px" }}>
                                    <Box mx={2}>
                                        <Link to={MyInformation} style={{ textDecoration: "none"}}>
                                            <Typography component="div" variant="h6" style={{ color: `${colorTitle}` }} className={classes.profile_title}>My Information</Typography>
                                        </Link>
                                        <hr className={classes.hr_line} />
                                        <Typography component="div" variant="h6" style={{ color: `${colorTitle}` }} className={classes.profile_title}>Previous Orders</Typography>
                                        <hr className={classes.hr_line} />
                                        <Typography component="div" variant="h6" style={{ color: `${colorTitle}` }} className={classes.profile_title}>Credit Cards</Typography>
                                        <hr className={classes.hr_line} />
                                        <Typography component="div" variant="h6" style={{ color: `${colorTitle}` }} className={classes.profile_title}>Coupons</Typography>
                                    </Box>
                                </Paper>



                            </Box>

                        </Box>


                    )
                        :
                        (<Box display="flex" justifyContent="center" alignItems="center" className={classes.progressAlign}>
                            <CircularProgress />
                        </Box>)
                    }
                </Box>
            </Box>
        </>
    )
}

export default Profile;
