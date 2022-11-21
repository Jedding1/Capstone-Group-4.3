#!/bin/bash

#This script requires lynx, which can be downloaded with apt in Ubuntu

unset $userselection
unset $url
echo "this script is meant to scrape the names of Apple Store applications for later searching and processing with ipatool and mobsf"

echo 
echo
echo
echo "Enter 'top' to scrape the store's top charts (https://apps.apple.com/us/charts/iphone)"
echo "Enter 'social' to scrape the store's top social media charts (https://apps.apple.com/us/charts/iphone/social-networking-apps/6005)"
echo "Enter 'finance' to scrape the store's top finance apps (https://apps.apple.com/us/charts/iphone/finance-apps/6015)"
echo "Enter 'link' to supply a single custom app store url"
#echo "Enter 'links' to supply a text file of app store links"
echo "Enter your choice: "
read userselection

social=https://apps.apple.com/us/charts/iphone/social-networking-apps/6005
finance=https://apps.apple.com/us/charts/iphone/finance-apps/6015


echo $top


top() {

        echo -n "" | tee ./.appleout1 ./.appleout2 ./.appleout3
        lynx -dump -listonly https://apps.apple.com/us/charts/iphone > ./.appleout1
        cat ./.appleout1 | grep /app/ > ./.appleout2
        for i in $(cat ./.appleout2); do
	#echo $i | sed 's/.*app[/]//' | sed 's|/id.*||' | sed -i "/./d" >> ./.appleout3
        echo $i | sed 's/.*app[/]//' | sed 's|/id.*||' | grep -v '[0-9]' >> ./.appleout3

	done
        cat ./.appleout3 > appidlist



}

social() {
	echo lol
}

finance() {
	echo lol
}




link() {
	echo $url | sed 's/.*app[/]//' | sed 's|/id.*||' > ./.appleout1
	cat ./.appleout1
	cat ./.appleout1 > appleidlist

}

#links() {
#        echo -n "" | tee ./.appleout1 ./.appleout2 ./.appleout3
#        for i in $(cat $filepath); do
#                echo $i >> ./.output
#        done
#        cat ./.output | grep id= > ./.output2
#        for i in $(cat ./.output2); do
#		echo $url | sed 's/.*app[/]//' | sed 's|/id.*||' > ./.appleout1
#
#        done
#        cat ./.appleout1 > appleidlist
#
#
#}




if  [ "$userselection" == "link" ] ; then
	echo "Enter the URL of the application you would like to download"
	read url
	$(link)
	echo Done

elif [ "$userselection" == "top" ] ; then
	echo "Scraping the top page"
	$(top)
	echo done



#elif "$userselection" == "links" ; then
#        echo "Enter the path of the file you would like to input (and make sure the file has proper permissions)": 
#        read filepath
#        $(links)
#        echo Done



fi

exit
