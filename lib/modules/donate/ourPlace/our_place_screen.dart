import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemo_cell/modules/donate/ourPlace/specific_place_screen.dart';
import 'package:hemo_cell/shared/components/components.dart';

class OurPlaceScreen extends StatelessWidget {
  const OurPlaceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                onPressed: (){
                  Navigator.pop(context);
                }
                , icon: Icon(Icons.chevron_left,size: 32,color: mainColor,)),
                Text('Our Places',
                  style: GoogleFonts.bangers(
                    fontSize:24,
                    color:mainColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index){
                  return Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(

                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: mainColor,
                      ),
                      child: Stack(
                        
                        children: [
                          Positioned(
                            left:15,
                            top: 10,
                            child: Text(
                                'Dar Al Fouad Hospital',
                              style:  GoogleFonts.lato(
                                fontSize:24,
                                color:Colors.white,
                                fontWeight:FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 45,
                            left: 15,
                            right: 20,
                            bottom: 20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        'Location:',
                                      style: GoogleFonts.lato(
                                        fontWeight:FontWeight.bold
                                      ),
                                    ),
                                    Text(' Corniche El Nile, Maadi, Cairo, Egypt',
                                    style: GoogleFonts.lato(
                                      color:Colors.white,
                                    ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        'Details:',
                                      style: GoogleFonts.lato(
                                        fontWeight:FontWeight.bold
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(' Dar Al Fouad Hospital is a leading private hospital in Cairo, offering a wide range of medical services including surgery, cardiology, oncology, and more. The hospital is equipped with state-of-the-art facilities and staffed by experienced medical professionals',
                                      style: GoogleFonts.lato(
                                        color:Colors.white,
                                      ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        'Hours of Work:',
                                      style: GoogleFonts.lato(
                                        fontWeight:FontWeight.bold
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(' Open 24 hours, 7 days a week',
                                      style: GoogleFonts.lato(
                                        color:Colors.white,
                                      ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: -3,
                            right: 0,
                            child: IconButton(
                                onPressed:(){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SpecificPlaceScreen()));
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  size: 32,
                                  color: Colors.white,
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 10,
                separatorBuilder: (context,index)=>const SizedBox(height: 20,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
