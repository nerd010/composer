ME=`basename "$0"`
if [ "${ME}" = "install-hlfv1-unstable.sh" ]; then
  echo "Please re-run as >   cat install-hlfv1-unstable.sh | bash"
  exit 1
fi
(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -e

# Docker stop function
function stop()
{
P1=$(docker ps -q)
if [ "${P1}" != "" ]; then
  echo "Killing all running containers"  &2> /dev/null
  docker kill ${P1}
fi

P2=$(docker ps -aq)
if [ "${P2}" != "" ]; then
  echo "Removing all containers"  &2> /dev/null
  docker rm ${P2} -f
fi
}

if [ "$1" == "stop" ]; then
 echo "Stopping all Docker containers" >&2
 stop
 exit 0
fi

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data-unstable"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# stop all the docker containers
stop


# run the fabric-dev-scripts to get a running fabric
./fabric-dev-servers/downloadFabric.sh
./fabric-dev-servers/startFabric.sh
./fabric-dev-servers/createComposerProfile.sh

# Start all Docker containers.
docker-compose -p composer -f docker-compose-playground-unstable.yml up -d

# Wait for playground to start
sleep 5

# Kill and remove any running Docker containers.
##docker-compose -p composer kill
##docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
##docker ps -aq | xargs docker rm -f

# Open the playground in a web browser.
case "$(uname)" in
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

echo "Hyperledger Fabric and Hyperleder Composer installed, and Composer Playground launched"
echo "Please use  'composer.sh' to re-start"

# removing instalation image
rm "${DIR}"/install-hlfv1-unstable.sh

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� ��9Y �][����3��:/��3����T�榨� �x��wo������d.��8�agW�R	J����^�Z��7�'��ʍ��4��|
�4I�(M"�w���(J�J���I��R#?�9����vZ�}���z��/�{��
����O�ih/�{=��ه����Oc$Zɿ�&��3����!4NV�/o����;�������_.����^q|�N�\������/���u������O�H�������Ӊ�ag���=���N�O��b��R���;�ԞG�����{�������O�N����G'�)�-�:ASv@ ,и�`.�P�.J(F�Gz7�g��
?G�0����>��8��ؗRF�����Nl�jM�>��t��Xk�֩R�.4Q��vO��M
Zy8�XOP�Yǳ�>� �8�0��(��!q��W��B���f<�-�Z6�`۶�17�ij��ɗ޲���f�V_r̹�4p�N�#ڃ967�hk�� ����V��(A��f)����7��XQ^z����S�����h�t�t�s���IU�)�(��\�^'~�������'�����e����Eݐ%�/���e�i�<p�!�e���,%>���-3�x�\���2@���d>��4M 3.T�,�x�LMk�y�DC)nЁ�sJ[ä���nD&�!N;�q;E`�F�{��3{�Μ��+�9�x��n�\�sv?>�;� =.TM(���Q��F�N�$"�J��Q�x$rqNޫ��s�%���-�(�i*;� t�|������i,"om졸�f`p.s�,ʦ\Í���-�ܷ
�@��Y����_1��㡹7��R1���)n�M�'
�N_

�8�WňP�<�9���n$�)a7�a/�-��bc���9}���)�h'�rVr�P����]i�Y&n��Vw�t3עf��)�8>�'�"�xy2�S4�E������3���'�+K
P80y�(r�r�,��t�1)m�&Fv��Ê	��R=0�6H�\�h�D�i��&C!J !P�/k<y:9�����	t	#.b�fu0���n����ڹr�Iڒ�hj�x1��C&K f�ȱh�sfы��(�e��F��=3��/��l������D��_>H���?�^��)�cD������_���L���7s(<:��P�қ�]���O�������:6K}o������`p�{�i2����U�>2�2<�$�zo*ͭ��3A>���w���]����t�x�͆�f2o�z�D���D!P����]�p�r'�v�Ʌ��'Zט#m�G������O���@��%�s��8m�<	�Th �	s@΁ ҳm��-LC^���Νp�n��3Զ��$tpaA�ܠ�w�=Ο��={2hBU'���F�����z�_@�I���u���N�,�Ҳ��h�����j*8���1���Y��e�$d��9Ɋ�����O�K�ߵ������B*�/"��9�_���cH������+�����\{��?���?��_
~I����U�/U�O����Fhsp�<��)�r	�i�)�!	�\�(!�i�d0�v<�tQ�	�����P��_��~���H�����d$�e���,���[�j��Z��P6m-hS���Zv�)���3�:VblRzw��xn��E���uVz:��)K����ԍp7��A*�D������8�uY����G�D�ˁ/Ե*��������?U�_)�(�t�Z��RP��U���_���.����?��������CT�_������#ü�ީ��.Yo	$��s�H<�3�H'B�~Ĩ�*�#F};��rd��A��`� �Ź���^����I���:��2��4]�!�l��b��p��#v�D���[�NeM1GkH���5q"5q1u{W���~o�yl��W��1ڦy�i��}߁��{o��]~�-C��e[�*�ቪ{�p�c�0<Z GZoi�rf�m qyQ��+ ��s�Ќ�\�A����}� ����堛��>�u�^��[��kSR�G�D������:��u�E��`f����d_��8�#�f5�7�~�&��� 7ؽߤی�	��97�~&׵d:\M�6��C%�u���|����?3����."�ψ��+�/��_�������o�����-�.�Ǫ��Rp��_��q1�cAT񿥠����+��s��w��C�Ƕ �g�*��\��c�^8���`h@��C0���xκ��8�0l���0��(͒$eWQ~�ʐ���(V���W.��S��+��JU,o86'��t�lc�=GZu�-���=yA
/����w�<��i%���䎢�$���x5�`O@��嘱U��v���u{b"�4x6���MF��sJɩ�nV���n<��q���o����t��[� ��'߹���?Z��].����˔���?nZɿ�W�N�~|Y9\.���J�e�#��R:�����������?�>������2�)��p�Y�X�ql�t�b)��(�s	��l<!p�u<�Y�	ǷY���j��4�!���p��U��|>.X��"�?��%�a��bB��vK#�Ļ���Jw�4Q?_����Є/�u�]q��ϥ��
t��yԘ	��G�׌�8��C0�2�v;Dت�L�5Aut_$�=��z���n|��)��MW�_)��?�$���1����>�4�_-T�L�!�W�?����c�O�x��]
^��j�<�{�W�@��8�Z���� sߐ���g��%	������q����r1��Zo�H_������ޜְ�Aw�`���4���i疉��O}vJ��y�Hw�m�=���o��}�؄q��1r-��f��Ex�p�LNp�ɬ'��x��bs5�9jo�EsI�٠��`�uF9��z��2<�Q&�=����D�:���6�s.���g ��ݚ�r�kg�&���t�*�)�sj�N%��ǆĭ�0����@ u�3"�mo�ey�����n7�n�����9�ۻ����=��"�v6�8�9g��r����b ��P�0�)��v���K4�[�3ۧwKkUׇ��9^(i��Ń}��)��?ET�)�-�
����	�3�PZ��%ʐ������O�����R����}�Ǹ0l�^�-��If�����,�#����{C��<3���#� �Kyk��I����5`�5M|��?�O�=x!Lbl'�����>���$���ld�l�k��e+=5%���ʱkiBÐNe3&ɜ��ep*7<��k����q�W��k�����9��Х��cs �5�͑��hmւg�.��}{��Y#Yͥ.���d.���j�l��;�j��7|��N�aFHt��*�>=l<����O����� �a�cT�W
~��|�Q����Ϙ����?e��]��Te���j��Z�������7��w�s���ad��k9�\��[w����U�g)��������\��-�(���O���Rp9�a��1E��"Y�eh��(�	�	� �]�}�pȀ�� �}�r]�q�v���P��_��~��BW�?������Lɖ�þeN�6;}�!Bs�m�me�E��#mѢ&/���hN�m�`]	otw�K��#`����;VaDI�1�ַ����0�k�d=�(G��b(���:�b��W�?��s?-��ę�����G���/�U��([?�
-����e~���~���\9j�id����d������b:��N�+���c���B��k��^$������2���Ej���8]�oxp��*�7�_���zul���~���:�~��I|=��ӹb�F���Z�&�+����kԎ�]׮�3��Պ`��k����~h�:����ˮ�;�ծ��)�����$��v坺`/6������Kvu��֧����ڞ.��fiGŨp훻�AE�[[�v�<�|W�ʰ��v���ꂨ��MCTEtn:r�U ���C�O^�}<��"ͮ��(�תJr�#��Q����8���G�v��}��]t�~O�u�?(��Z[���-����`{�F�S���g���{�yˤ�>��zqo���3��z�T��bw���Wӻ]��o����������3�X���-��jck����<N��ex�Mӯ58N�p'�zg����d�\*������ÓO4a���"D~��j��Ծ���}��?���Y����?V��Wtñ�E��������w�F���Y��{�@�Uő�m�n�ǧM��3B�+�Ʒ�r��
��$����N�t��ϖ�u�p��~��q[L������lW�>����ٻ��4�����_�g�]�+*���pS��Ԙ�<>�L�v."����oUw�07TL$�.}NV���U�m�2g�(���!bZ�֎w��Ǖ�^<<�٘��G�v����t��Q��6KT�&��A_6N+^�=Xi60� ]�0�0�"=P9<��r�0�A�-�ȑ�M3� Ģ���bhby �@6:1tVɂ��Q� \�Nm�"Y��#����G�&X��&��#����������{G��!�������w��y�О�h�7�]�D�>p�5|��X�,"����I��">)��FoԖ�����s��P���X��P��u��8/�h������7��aȫE�Y����s�tf�%�.��ypZ����_N����%Xw2�㫛;b���H�&}�pt%���[��\��d�4U��e�R�1I��򳠻v�:>BX�X&x����D�
�R�2���i�D�Z)J@���m.�y�7�|Zf-\B��l�#d���]FvXr�(Zφ���M>�0u.im|��;RO�̠'��H���,N��fL.$��\.RH�o�k()�N� �S(/�ׁz����}s$�x�(8�[��sz�9"r�$#:��_"�`t4�XF��h	Yb�8r� [{�c�q�F��O�Z��遯��B��W�ހiϨV���8R�˕�\��r�����h��lRX����O�x��Uĕ��O?z�z�^*�|�*��;t��'���o�=�W�s����
������BҬ���ʮI=%Z�0�f���2�yϋa�T�A��s`��65uIsa&�o���G#��$������~�'��z��T,�C��,�e1)F��1�5CR�'�X�o����q����K������o���d����J� a�)S��S��
���&�!|�Z�����Gg��Ƨ�����B~����
|�^���z��o���3��#�~w0?�oK��I���UҸ��\Sx��O��"��R�Hs�����c��t��{�_/喿���������q�ڸY�SM�&�4s��LU���i���IX�&iz�uvM�˶Ne�4aB�Q�mÜdxF���=v�!0#��g�5Ɇ	-�Yl�)_��$��&a�9N<<R-���c�d��<���_�h8�@��՜���ƿM%1�{���㿰|��B��������:7|ߑ��a�3˦C�� r1F_���
��Dp���{�=�b�"��B�Uh)�2wE%7�и��Y���Mo�!I�=�ٌ�8>]�N��Z���f�˾�_��%��܆�э1�5*��O����0������|�X��|a9�_Hz���}�@�� �㢏��q#	䁧}�=�|���\3hǢ��ן8d2���#1�,�}
|+g��{��c	T�-�	|��lLB1U�1
2z\k�NLG��l�N���5 ˡ���&�{/�ݩ�v�ܳ��k���tgإ�	*��׸��	K�t437�N��&!�bT�1T����\HZD���
k�y����=�c�_Z��	_	����o��y�^��c�n_D�6�Ȕ��kp$=zb%K6��w�8�!<Q�i ��'�d��}�^�W�N��,ē�|3\�K����t���I�5�/����
o��m�*�6{}�s�-��w��7�O��?}�k����":;0��@��J1�∞�X�Cf�>�Žc�����ݒ�d�.�̭\�&03N��E���Kz¹���y̿�[(�/�����P��8�G����,������/$��%��U�������*UF�D�9�I�)�VD���oHbb8d(M`f����"��LG6�s뚊�Fƪ=`|�Ҹ4�..�8`4�)�� �l(�������	�1�~V�Ŭ�A��8l7����*����-�.&�
�N�4�d<�S�1D����o�cSūEk�2z�X2)�QT�6ծc��Z�/ =&�d��&��
��n���D.��=�����i��l���)�֛���!|�!��K��<��
�|`�fb@L{�*��ڔD�V�FTV{�N4I�;R���#�M��a�7jp��h�P��%�h��Q6�H�j�u���-�� 
tlU#��^M%�{l���?��y=˟ӳ�9D^v�G��|���a���j��o��v� ��R`(�,+�V�KD���
�u��D5VW+�B��BP��~�x��r,�Ew4�s�o�T%�D7p`��@P�b"x(:0�J~%�P��jR`:�Nz!����>��Kק�{�J�݁'2��a����G��P�&Ӿlw��*�_�8+RI[�~J�B��n�A�GR��?A���(5vGl@&���AQRWWbqi�@��kd����'W�;�l0y�v��Z8$��������q���LB���t�NR0�[dO�{ni��m�#����d���#t�SZpd:����5@���g$�Ґ|���=�H���&X�	��+L��=*?�a�st�'H��ɥ��jLG�}d �@��d&�mp�d1|W��ʿ��@7{V�M@�٬�Cjbj�+���cr�c{��F��3g6q@�1�[JhB�:�|'�d�D����d���ҩa��1�7ԍ��P���%��uɖ�p��@[4��D����Gߵ�)k|%������h*��W3��l�p;�i[��'p(��a��f`
4��C��珓#:L�]Q�'-KK۸���N�o2U�BE?�OI�"�b������U��:�������	� ��|�ب�O�y&�ܔ�\4t$�	����rО��L��xE|�=IA���Pb���;�=�������;�v+D-֟�DO�O �g�u�ӟ��� �3W��9� j�nBš_�]S��X��a�n�u�~�����ć`zl$L�~�X����iZ�͉�h�Dh�S@_�Zf�|���������?�Y1W<��|�>[r([JM�C�.{�'3m|\��J�<V��%��em���y��B$7�C�v�O��~Ne���ZT
v�!N
��vd�z�M�MC�p�������ɐt� ���67p�B�C|�
'�ͮ�jJǔtKb�A��bd�<f��;B�@$j>�t��谱o�J���d���OІb��g�l~������#��0rm�tA��L\K/�$���1cْ|q��s?Ggc�o��r̢�MUVL��T |R�F{�1��INI���19"����%�F\�a�G�%�>�>�&�� �52pf��d;�\�_�=���G�����	��P'S���0�G��P��盨��7NJ�ѓl�'�	
	5s�������+��t�~��͆E,�]�q3eu��/�}���d�)�i�7�r��
*�,�*գ�[x/�뿾�������ۈ���o�����&ެ�W�}�7o�}�Y{t�+�J����ڴ�FV�n��Jp�?��%حS��w��zh�d��3�W����E��,JOc��Y$ؿ�ī~}Ƴǿ}��HO{3�#�?��\���Fncy�o!	_���;����8D�dH%�F�إ�*|�Gz+�����S�$Ҵ�N�	*iRWqr�Ky�ʟ�?b�-#�L�[�2�&��U)�"l����]O-��Oq��`l�w���(�36 }/P�N�@���e��s\+P �Z�r$�L{��̾�[�^6{�G��/��<����2�6_k/��,��{��X�WhbL��?�3-$'iDeo&�U��(Uy �i�X�IY%l���t����y	C
u?�緤-G�<�m�N�����_|ED�FH�&��p4�O|I�����Ɩ����:�;��؅Q$�=\��uO�mN2�*�x��c��-v�%�Ҽ�Ai���G��'������U��P��c������<�޴�֬#0�%7F{q�0h�W�Y�E_ͮ�(=�>?��vCy��=�c��)��f9S�v�Z�2ߟg��jK fO��󜑡r�F%�v`P`�ú��O�퐙�`�0X�5�����+�޾`��J�${fa�cY���|�o<�bM�%Y���A�cR++fx�<�a��Tk5P~��?���8=�� !s��a�
��ٸ�OѨ�BLMM횒9A�9�t1��
B����"�}��=�@��J!��똪=)��F)�����f�N[F͐f�!sݢ���gb��$�V�ֆΚ�[��6����n? Wƴ%���)����k1����#X���������v�=�K���!��|M܉E�o�Y���)t��?V�R�8P6v8�O��A���.�v6� �~���:�@C�&!Z�DN=��QJ���q�&*^d��Do� �4��U�����tl���{�u�J~V�R����3��3��/=��3D<Ca��������0���g(ΪRz�U�Fφ{���o����q���};W������8ܐX�K��8�lR�][�.���
_
���eH�8垸� �����0���ha�7�����x��"�IɊeh�
;T�r-��%~�L����]Q<}���[n]��cK���\Hih8��� �Q8v��K{x>�]	á/�.�et�Ha#7����X�6�+���F6CU�CCA6f�꧿DȈ0'/ݒ��Af.�P�U��0�";�&`W<���5A,��s�t��2��	x"�]��(�.��ۨƘ_�9lp���A����S�2S�,��`��MZU�t�l�����y�]>Rqq��,B��G��̻��1>z"�y�ix��v�F�@�E����(�8WM���3mV�ty�q�l� �-�ã�m���q���@7�`���
��7��sۅ)@��7Xu%Ľ&! �JE�٪��$�Fד�*�݂����n�����w�����b<�����]���6�^J���>Q�?z���s���'����F��[��]D�f�G'�s뿘+���^Hz�{K�.���_(����������?���׋��?,$e�������/��w���:�7�/�����K������H����C���������;���]�`Z����������^�o��_\��"Ң����Z:�ב��������͍(�o.����-m���º�+I���+�6��_wk}�$��s۹�fQ�*���R�D{r~��/l����z)s�G�E��C�����A�_���BRS���<$�Z�]!ǧ��J�A��,/�ړk��F�Y�?n�M>���ޏ�N����n(��v�}V�����l�i]O�[����n�o'*�ƞqvR?�Wv�sS�ٿ�}Y|�m���Oj7[c]�߷.~9��?��=��[��Φy��21�\�;���z��J�����{�^��(׻u����߽K0a��Y����J�k��������X��E�E����ί��5������_��1����B��7#�_3#:��}�OL�`��_/������-"����i��Ӭ��I�����^�V��G�ʸY���'-}�6��Vn�.���s�q�~�}��_���\9:>9�W�T��k���\��ONv���gw�NU�g�Z��Rر���7�pct�i\��',�z�:<+�8���I��b����K��qڪl�ʃVS�=�����ǻ�m�S9��ϫ�V��W�>~x,��Vu�C��i[�ָ��.s�s�C�ӄg����l|Yo�*�\�A�v~޺m�UN�r�S�>tw�a��ޑ.�;_*g<O���!O����粠�]�<�Պ�1��Y���������S|��:Տ�jk�:���J����	��Е\�R=����zk��u��ծo?�l����h��ٻ���ul�ݿ��5w���oC�:��_���L�����68����6���N�i�h}I�dikK��K����[^�ݲT�����M�&�Ud#N�rE��o��qA�,��9�������13����QI�1��bܕ�.��\'�A�4/rU��%�s��0�,sE���Jq#����Y�[��Y	5�n�k�e�¦�֮�t�a�;�W�R�陣�R9�2 ])p��)�P���M�����x�*Q�����`:��hV�m��\��M#�m~1	��p���])�����i��Jn�s���'�E�d������<����,������w�������������ċ�?i�������r�\����+�����������kΑ�w�C��&eb�t���������_���H"�x�(�0}*�wn���^i2��@����q}l�.	Hɟ:Ne6vfƈkw�A賍��im�^��(�뱱ftV��1����k�s���Z���->�Y����>Y6<B��"�Ni}���v)aܼ��R��w���X��r#��֒$�K\�V�99�D.���.r�-�c_�4b͞�W@����e��EQ�]~X��o��ݑ:}6h�̉|�s$n^�́�fw��|�"��.{�Y��զ�\�S�>��=[�k�Q+5��5|i^��e~�T��Q�ql&P��h��������#�ξ����s������_�����l�/���_�����p)���\�x�1��x���?�~@�?��r8��G@ޟ3@�����\���b8����?�h��������?.���cuB#u�0�dTF�T�eY�e�M����1�11Z3q�e������:�c&e��	r���\o��!c�&��U�F�vl-��k��x9���U,�̢)8B����6�������a6·��;�Bբ����ٖ��3YW����edT��I�ׅ����,1��2�j�aCS,ta���"�?��q9�{���?���>�����\���� �>�sA����?��������s�0�G� ������`�a����r���u�p!�����������k�mǵƦ�]n�hMa^G�e�"�y7��j�5F�B��ƨ�Ps&R��Mk��Q�%VTppn�L��5�"o�W�*8w4PzJ�H��,ž8�����V���7�+\�V�b|0���ޢ>��-_'Z�C:���?�5JD��Je�Dۨ�&pݣE��Oˑ��??-G^��-G�r�h�T����H"p���DB��ݮ�1�p�a��A�r~AḸ���B7�=�&w�mX�dK�E��6�>���N��ݑ�uh1��+���{>h�^��=N���n^*5����v#DfɈ|����V<���Q}N�jyk��Fil�%�#g����S�������7J�>�1ҝ�ć��ϑ��������������˃���?.�K�x������������x��q�~���Ռ���'X��gA���r�����9�9���?ò��?�����\�?�A���/<�;~��o�TZ#uUǵ�[�IiT��M��-� ˺�[:�c�2��X+ie��h���e�fT��������4�����?Z%�-	�岥�����D���t�>Zeٮ��]w���.-~7�Na}͎�f�U�nP���뉧.��=Q4D����cb�V�z�w����;"6��9�*��a=�3�ɽ12����f3�a�����<���0��&�io���I
������/����?I�4��s �?N���=~������%���o���<����G�?�a��?�B�����\����5�Ҁ���������a�ϳ���~����K�e�>�w����Y�-c�2AYeB�T��K*Sfp�`0C��eB5�`1��u�"-�L�,K3�r�l���}8����/�����,x��o�[+K��+��3�a�� �9W�61_�v��p3��{����^\4
=}�k�^O1� �"�,I�l^��;� �C�6�w]K�M����\lh�&�[�P"�bK�ݡO�éڃ��F������?�^��� .��>����O���?B~��I2|[�l���)���_����g����j$��c���Zʞ��,�L�En0�V���u�Ǌ��������:�>�TՍ%��RU���=W����!�Oǁ���āD� �9�q*Z&�4Tx9��Q�@3Фëm�݀ ���߬��Ƿ���[��Z}u����/��{}�ւ�0'=�8-�ũ�H�MZ��И��r�
{<�.�%��`��tX�[�����!��{R���^��\;}���-%�vI�kY�8{}����c�K������V�)Y��ҭaVEҷ���|��НJOm><d˫��ݩ�,�+T��4���0VB{��R!��Uh�j��K�ë̌�MAхږ��s_7W��0�E(0�R[�N�z�l�[�Bj���⍂�թ���,��j���xY�ݹa��U����{,���u1\������0 ����_.�?�@�!�����
�~=r��_��������/�c���G�("��hS5k
=�w/�����/G�,L^哽��� r�q`�ŁA޳mq�k��DN=�&=۶86c�q�ר>�����`=��l���H��U�N�����XU:��j��O[|9�L�"�c�i��Z�]"�x`p
Uh��x��-����:2�J�y�K�P!"׏�=�x���a-I�t`�}@B���X1�T9���}�|�)��0d<���{�jͥ�*U�٨�ե2��U9��I��бl7�N�1Uűܤ�Q���d�5�U��T{�umE����}<������W����<.����A\��l�/��|��o��,ȉ����B.�?<����?<���������^;����,�����+ y�9��=���!�?ra�����g�Y�?d��Ź���?Fѐ����C��?��=�����.����A�,K8�3%��˔^b��ИI�%�HV'1��)���&c���1�NhZ� �W`~r�������?g���pJ}TQe�����W5�b��G��7�u=tݸϻn��|7��`8��^CiXD�BV�����w�"gQۆ�)6�����x���EM�"fPd7�]���3��x�s�W
x�p:x������ba��D������u���a�t�4	��"(��h뛟������9�xxr$�3������V���c���Xt=]u'^}e1����-���}���VE���C����Nk<�/0�+3���槯��z�<�m����K%�����7�Tz]3s;R�~�0Qʸ=��Qk+���+�N,���%��xЍ>Q��K�>�~���/�IJ��*���a����S�h��ӚH;$:��73Oq��|����]���F���k������g��n�i����(�A��6�\�����䣠�(�:��O����� K>J�b�u���>���oI[o���-��"t��'D-�5Qs��~�:T����Dc'����K�M����H�Up�~Y�Q5Y���e$��[5��좛e�MY�Z}�x�p�a�&��	@c�-��@ ]Հ���^��v`���K�'r�g4��(V3)�p�(p�U�D_�@�O3 ����G��'���r�sRȝ<��������@��h��
�(�v���\k�6��5��@=��� 1�D�����o�OD��L��7u�rtд��Rm�=0��E�os'Lz4I1�3w����lWRQA���MZ�GW�!�kF(X���J���[H�����H��*��L��C�>�=L��	Q�G�{�|[�h�Y��!0=�B���
����v���������7���<�q�(���vZtV�mF�����S�ސ5 4i����A'ߚ��m�H���?�+�o�M�'�W������Z���D�B��o�^M"�皷@�kЇ� w���|2�3��^?�/���jBJ�+`R_'=x;������/�9��{�]��(U����%|CM ��%Yx�/O�yw��uf}ܫ��N�b@d���(��@m`|}Y�Q���#��A[lE[{0Wg{;���
C�|�[�����Z@��9nW�P�kd�:�m��6��0�D���=� ��O��Br�z�ͫݜި�</
;ٔK4p�w�^�c���o���� �ނ�7%���uE��}��"��~����@�G���d��+��Y�7�Nʸ���>0/���zH�~*^��Da/.&x�f@R>?I��ɯW�9��z�����0t� /�/��$V4p�tZ�?�2�K��'�����o�_7��0=�ϛz��ӊ���D�`�{�h�Mj�N=(@4-u�F��m�̔o\g�%]��8��o�T�`�/���k7���}���X&��}YY�}�f#���H�u�tIJ�K��\��&�(ÉǠ�ɸ��L�XX �}�8��4�4�PE@'�<`�'El��f�<oƩ	��ĮZ+�}�>1������]]=k^"+hW�B`�M����^��"���}O}��i��<��h'n���a�}��^�����SQ7�^{-?m�-z�TR�o���I���l����e�2^Wo:gV�I�S����d��6�O'�A�_S�rL���ig���g�*[ڄL����ޣ�c�!}0�	�1P�׷�7-�PF*b��"T���O�|@H�|vfNǭaj+ 2zȅ~��_ӫ��ߧc9YA�����c�[@��0п�%�?�߿�y�;����e��bd7�z�&'�&�8*=ٶɰ!�g���V[��x.;���T���x���w<��H$T�\T�**"�OP�xA} $D���VH��}�/c�mg7�s��>:�^�������}��g��5c$qd��U
!</�u�����9\23����F7̅Z|!�A�����z`��
���?�t@�r��Ϗ���Օ�`[���n��c�50?��8����YY�]}F�9��y�[������y�
R�=��\<pa/�1�
+�ؼ�C:ܮ��'�o��<�c�l� �七aP�z_>j̱�c�ͭ.� ��9��>0A��h"±�����:$��G�C$��ܭ�����X5;���F�s�B��'?��������"X���؇�
��r��1�Mn�9۝�:lpz�Cp�.|�뾴e��6|azkU���W���c�U'Xz�U���{xW���r<['�5���ո:�$�>��t��v_�o��ݼ����n|�vXU��c�S߱*a�H�]�����G��(��q��3����|�{s|�F�p�t�U�
5S%g�X�{�X�d[���ڠ��4}��R4s�
���"��r���	���wS� �e��a&�d��y<�3E&�ҭ%���L�
� 0:��k���\4�`�T�J�e��h|�~(�0���V<��ƭ
���l���\:<Q���K����r��D����
���9�M ΀������s�s���@��$�
����.�+{�+Ӵycm�T*OS��/o���mÃe{ )�M��~%j��Z�H�;U ����c!J�!��#!�9��4��#`W(�i�t�i��`g�3\� w��Q�̲���D�(���4J���f��\�ps����e�-h�8q�5k�5vN�{��T�Vٹ�a�
=8Spw��p�@T.Ip�,���1o����(+�V�TW�@�
.V�	V�h�nK��C�N`�Y���ހ��Y��O>@@h4���Jg���\���>d
���A�.a��R<A���9��I:dΙ2C�L>�`R����sK���yG��s���@!l�-ɔ�'���7_.&�I�S�d�d�kM�	���|Ĉ��a�P��#�h�Q�4�
��s�o�jS�:QL�r��d���D�*�J���4����ްĊ��T.M�����Q����󔹆�\����&��κ����3p��#��E?a.=Ć�K~�\y�Kj��l����V�EA�Pse������Ws���CC����^PЊM}^a�pd�A�h�Q`��4�G�HB�.��0h�X��`��1��\^�!��R*K �:Q�|5e/�\�W���U~�<�r̉j�6�ө	�տ4Ӎ,�0J����d�.l�E�r��͌A�$ie�Rz�h��ԭű�xlp�B�y� �L���#�Y�攸d��C���߫��`��������3xFR�_�5�]�;Yt�Q��y�9A^�3���C���]%�$\�����2�O�#\狌����'\[��'\�	ɧ�z�<��zB�5=!�	=�9��]��>�����ݧMml��w8I�{��O��i��<��߳}�����%F����?��v�����������71���?��<��q���o�1/��γ�������������>�E�U���[?��̳?�����+�3?��������/�ʏ}�~�8��c��}�Eu��}��oa�|S����~�M�S���7�_�ƛ�����%���M�T��䫏�̓�Rnz�mH����kLɻ�Ƒ&�L�q�'�qⳣk�6U2��cAj!�;�$�p`��BQFϋ�iQ�=Jb��t�ߴ{�z7�)Щ� Q%�d��NJD���B�-���jv��J�L�D�.*���y�ܤX]��6�˳�ӗk�m�5f��q&���`~6Me�03(�;�1!��v��l�p1�t�����)�l"��P%�q�,`)�x-�0�~��q{�J0:����F0��O'R�s�.7졤pVq����8ֈwΊM���*�z�m�\S���D#)����b�e�A��v��i�H����`�
�٦�m�[7,���9�� �֥��6���23&��|���r�"�o��H%���M�j��J�*�����c[�lKʇT ���=���RBu@�����'�^���	8Ő�1��:�FB&��3��1�|���B#3��,k(3f�d��&2="�%��p���\|�X���&ZհbK������9񟖩 I�C��Y��X��*W��7�	wY_KvS-�¤\F�r�ag»f#���&�D5/�bI��2���x}�0�d��yD�BXN���hj�*gq�׏��l�u$;��g�X�β7��"L10�gU��Mj�"�+�{�n,P�ǚv���c��4�c�j�j�Be�DQ.�p�)��X,�Hx2E*��K²@l�]+,���
z�g�3��&z%V�d����1�b��D�"��Lg�r�}����)��Rᖗ,t3��TO9<�ds��%�j<Ya����
a�l���qF�|&FR�5���^k$c�)�L���p&wՒ�Mx�,����L���%E���Ea���*u6��.���
g���	�L���4L��}E�R�p&m��*\�\�b�Za�����ǧl�5I4��"1��㲷աY�Qp瓎D����e���п�Щ���sZ(z\��k��SM�&�I�+Uv2��eߊ٬�͊ٶ���nP��0y߉���Y�X����;ς�~�~n白W�O���B�~kp�B.L=���6@�yC�]�c�[���W��c/`�Z�5����7w��>�y�l�ޏc�F40/]����n{W�I��-�E�/ΧE��M�l�����a�RL<�A��|{]���J.#�O�w��L���{�P�O%��o`�ˢ �؟�����;��_�/h4.��_$����s:�}�� �?+�B�����>}~u��"�񿾍ݤ��VT���?���K�7R>��~�5e��v�����;�i�uVX�uX�k�z�OHO�vΘZ��t�>��D�>7;�-	�Y�Q{j&���#A��S��1��x
R<����LZs��u=��+L���n4k��5���>#��=s�ߕ��fZ��7���0�Si�l�2����d����N"�n#{����i":A9�p)Q͘�t�ٳ�@Ƣ&R2z�Eǌ]�3�3]U���8_#�bϺ� ����3sȈ=YH'/M��?!�c$1.W�G��'u���Q)^�*����g�dl��x��8�H�N�Ҥz�`f�f�T���s�!^���
��p����Y������rX�a)��u��J�k�}��V���[���^���ї�s��I�������s ���! �	�"5��K�z,v� |�P�e��^`��F�pk�F��K���M��X"-k����n��$��;��R;W�J�_�1�S�i~�cݍG��n]��3'�0:�nlۏt�-|�[s}�u?ҭ�
[�}���o��3)D�O2]W"F�Y�@�L�!w�ņ%_��#g�τ˧r��ѽ8	�all��!��H�2Is�^��,���T;���3O�<��K��>@;��TS>�8�F�S�lh�JPȩ�c���Q&�l	����t���"�_���%g�D�Ue:�a��d�b�b�3^;V�{���'9�"�2.�G�9{�ݖ=�b�`6��3���Ob��z��i(F���H�A�'K�O���&/v|`�ޒ��l�'6*�֑���r�S�-"-��׼�9���+�M�5�&��mΑ+"�G�w������n��!�%4D�X����v#�n���C���d�Z 7�����vw���w�]S�V�0o���*���S��4�w��@aG_�ǟß���a�Π��u<��5��4#�m��%�v�׳��� �������?-��O��yl�C~2�:L�6С@rJ��*R��Bi�F���C�O����R���X
����#V9`hu2G�S��x��;JK����_�W�AWF�;�C=	���s�?E�4��B�4A�-�,V� �w�AW" �$��d0;��"1�D�'��=��.P�K��Z�́��9��_�:���>�o	S��c�	�[��h(x�7`(��� TK݂ބ�8Dh妾i3��������j�h6վj��
jgaG��2쯚�"۪<�*��"s�dG`.x�gS�k�t��{�����J��,7�#��h���P�Х;�����Z۫��*+@`�#%�����z|M�B������D ��
���� �V5��9G5�s���{l�����<���n(��Z�Z��)7��r<����CmQ^�`:�nk�\V:W!M��VPA�l@�����`���Gm�s������F,#����>�f :`���pz
<*<�Ƨ�a�}���4G-9��H�W�bS�"��{�X|�^�_���R�P�:)6����.��X.��v}��k���Gn���
�%��2�E��|Wb�l��>ۛ>D4�}�d�Bbe�_�O�(T|^����16�S�$��O�j��C�SI9ET�!��ֽz7�4lS�3�o�/���_V�wıs���R��D����:���
z�����z����	�X��� P�:nR)
#�N���(��;��۷�H��3*벐k�z�BA�֚��w�P:�ZK�����h��W{�r��!�t	��oBJm�Ȗ�l3��4*��<���f��i,��h�S�4�ґ҃��Y�܄9��౮�P�f�ρ�ʱȓ{�`�ˬ�hxl���]yAܱ �k<ԹV�	�ؠM�to�u�<C}��@��� 9E@H�VɊƗ�0k�l�@�W��fM�7Յl�����c3�0DtV�LQa��*`���R4�UZ�p���
X��<�.����� 0n�gk��VE�
5��l�M����̤Oդ �>���]����T.ϣR�]_Wa�)CL :g�o��{��6��"�PW$u{]��:�-���0YaZ�)��q/�6Ej]y��nA>�S�4��({oex�U_���%ͱ/��L1���}�N��<&�EQ�>���5�����[�qi��Ǿ����ڭ���r`ߋc�c����n�|�t�����w�d�ᵻ�u?	?�gɪ��{�N���fy��u���z�nw�|���$��(��q�<t����>��+�o���Q���s��e��������O�ߋaưy�{߈�lH��}���$�$q+I�J����#+I�zm�im��&����$q+I�J�b6+f{��S����ѷI�~{Ŝ󍿾*���yo���$Ҽ�y��B
����3$&}����V.��(�r��t+]��e���R�'���8������EX�K#��a�Jb\I�2-�/�FH���5b O�s_���l����^ʮ�U��}_��h8��8pA	�	!��i8p�-!�1bnp@�b��e��\�Uf�T|��r��_�D��*���4���G�����t��ty��y��O�!�/���@�5 �C��\@��]�������_~�������}����G_��w��7��̴��ޫ���z7�}���s:�� ��i��e��<)�8���q
����H���~-��	��!�4&.�37f�jO�3��7b�I{0��Q���a�Kȍ��0�9���y���|2qc�vax����N��/�jL7b�M`����[NߔU������_{�F�l���^�ܚ;��~���%s��#n�Rg�~�ٚŴ�M�V���K�+���|�ߚ!?#��&\�ºw���/�������~/�v�y�'������X�wp��ø����P�^y�j���ύ�{�?Z�����������{�~q�	.��M��=��O�&g�����I��^n�=6r�>#s�#���sN�����m���x:g��j�����倗��$���'�� ����ٷS�YMgf�Sט��z�mr��;b�u��:w���ro����i��=O���>��c+�����M�yl���b4�ᖛ����*�t�Յ�Ւ�u���p>�>c{�'���ϧ���c<�<��CQ�_8��;ãe<���c��Gb(�ᰫ�FR�� ��IQ�_����E����U��t�V�=�*����d8pn�e'YN����I�#i�oE��hg�K6���	�F���0��bz�����Kh���t���h����#�T����>�:���:��(b�&��4����X�1��[:��4�#�����L�B1A�7�n�B�y���m��cƱ��g�N��#��O<��}o>�7��3���l/��s�����/�t�z��=ٶ
� *�r����nrR�"�YAP�r�|��s�h�oY*�b%]޹u�ءI)w��/j�<�#���x6'�����vE��G����,��BO^��+�8�ˉγ��NYT�[�b㰴Yo�--�t
��<x�;�M_l����R(Tx���[_J���o�X�H�����:�{��ޭ�ZU�A���,��f����HL'z�ٞ��k�n{��c���1�;���'#���������"�	�v#����q�9R���������z�N��'��/(��f�<_��.�ՊX�d�P��c\d�ؼX��s���7�d��ł��������Dk8�%�$1�6����nG��,�N�u������r.[P���O���޺�#9[�B>)�\������G�ȩ�B�,o
J*'�No;u[R�k�i���9�RT�ln��<�41��p��qv;�}"�?ץ�N> ���=�y�
����ȧ�h{���JEN}�;�4��ʂ��n���;�D�6Wq:�SJl#�S��!�qEq�N�tZ��r�$]������N��-����B��!�/T�
JVvzλ�p��|O���9�!b���^s�\l���НqȄ�~�r�s�`��q�k?����O�[�_������=�+�0G����8���vVԆM��l��x��1�,��"��t�<�NO������<�S��@��{��v�o��=0��ۯ�'�q�����A�=���{)�����@��^�;z�-���GQ�^���ϳ[����a(������7s�A3�t_��;�^]��#��`!a�'b���=l��M���q��������hG�OpA�����;���H�?�?�?��]s�/m��6 ��?l�G)��	��A $�'L��0Aq�"U���YI0ο�S�j�0[�Ө�h$J����� ���K5�W������_�����O���A����e6�Y�ˊ��JZ�ْ(J|�(VW׹R����z�1��`�3B�+WY6����\���;�a�+�4���R�gRe�.�����S�(]+����|ͯ��xn&�ZפSX��,�h�v�n��dؘ��,��P���`k9Hj��ŉ��EGQ��#z�����?�������9��������E�?�� ����� �*�7�:��1���)���4�Ɓ��1̰{f0����Pȡ���/k��2����������(�?�Y�	�AX������H����� �x��;����w����X_��&L�r�3�Y����������~Ƚ-�~{[U��;�ќ�)/�p�@�=jŋ�d���56�X��w��'�JaL�ٕBٚQ���#�U)T�}���$	C�^���%�"��8;D�4%�9/8���]��Omb78�+U��.��vV�|+٬�N��Y�l����V��Z��̝ۧ�E��h�'Q�q���9�[���ü+pI7	R?U�ru�w�j����ZMf���2,7_�r�#g�B��4y)���'�&&��H�'���5�1ͦ6	wy�!m4��jf����������G�?0����tx����_���G�������p�L�G�����h ��`������(�@�#<i����������H�?����?��� ������Gx��)��Q�a�0�TIW���d4W1Cg`�4aB3�"	�U� 	A`7���B���G�8C�C���i+ޫ�[�Wk\�`%kQB�I�G��	�Ir|������nk�Qe>�Z��Խ�֐�A�EX�ӳi�U&�6a��vk����*A�I�#�xc/K�5�D���;�$�A��%���\D���?�C����5 ��u����@�#<���`	P$���	`�X�����?@��/o����������������mc �!�?��O���o���7�i����j��8<,�]_,bx-�;��8z5ṭ>ǡ��y�Ow�YJ��2�fײ :e4/$Ug����+����Iiɯٌ_@���jY�mH�0$�	����Ϭ�~�%+;�z�Ң�TWxSdZZ??���b��o����{��JNv]�����li����fˡs���ϖC��j�-�X[hz�zї�p8������gJ%��ȧ)�-U����b��>?/����C:_��!�D�W��4�K�֝IVa�L�����%�)��R���(IԮ����ج��R3C��)畚lGU�u�(l�]G�~�b��M��ro��Y��R��LSY�a4;ĺ\�UV)^���m$K�ːF�W�Y}���}D����!X��D����_����p�L�G�����h ��`�������]ݺy���(A���Q����Kxx�����#�����������?��_���ŏ�����^��o�*�a��#�"i�NS��Z�e����cL38B�Lkl��� C�
T>^A��#����t(����<�,��x<�����RKt����kCK���.��E�G'�?.kM{��S򄼪$�z���z\G� �����VrV_T�bU�BQ�k�>�xƪf�+�kՍ��쒲M.��&��x.޳�'�9�O��8�AQ0�^��o7"^[8��1E@��(��N��א����,��(�����w%A��H�?E���!!0���q�߄�������G� ��@*��t��?����C���g@��3L10͠�Š����N�$C":J�3��eP0��na��ei��Ќ�����"(�?3�J����������+k���H����ƳYt�g�����C�0�ӈi�N�����'ٸ��9�Q��&�2�-r�~�#��8ߟ龴.Y��0�lN�DVK-aa��OE�$�5�,UG�Z��
��}6���G���_�?�P�� D� �����G��1�?������� Z,@D��Cp� ��������e����5>��V�A[�7�R[�����·�L
ly���2��TmuTU���6�j���JO��V�V��:��ƞ$��|�$t�ֲwoͿ3�*s���إ�s�E�y�mh�}Ua+��7�uwe's���YVɗ�ʼ9�G�^�Tz2�������\�#�0(M�Z�V�jt�u���S�#���KH�ة�Gy����6cHk���R�>Dh�^a^[�D��]���6��5�9�hs͆��f?�-����gK)���n
�ʚ�6�s��@o'5w}]��a�'t����x2W'�Eq�M�ɜ/tn�
!/���O�'�mN%��.�ΧW$���"7O^OmNLyRk��5�CVj�+ւ�뫥<�MrV1i')�8�;�I-�q\��M��=9����x�H�@�+4�j��t�����������������@$��C��O�)��_��,��f3,�Ֆ�Z.-Un}������/;G�o8�w�佱h+�T��{:0�s�-�Z@i�U��&���=F������Э�_U�u\���0�@��O-j�iq��K�rC���	�U�����9f�lQ	H!�z4�ҥ��v�`ed�$���zTΏRC�M����w]}Ne�����?�c78�TM�����	$$���'�V�,f��ܸ�й������P�cW�u�����|&*�S�¤���jw����f�ۄ-5s|1���BC�����"��r���W�xa������������������ T�������_$�;���A$�L���H��`�?4��0���_���K���?���Q���`��	�`�GA��3�7%0�� �������k�G��Cq��+,���\�(E��5�`p��L%	��1�B,��13\#,�$-�4aR�QM�Qd�xIQ�����?`
�g��r��T��z���k�D-Wh�Ykz�]d�������^�l����T�]j���ZHb������k᫬�L���L_sH|��X��VG-3
ovp�#+%i�"t�^�������?������'��妓_j���??��Q����������~�����o?�_�������������7���������$��W~��_��堿�A�_��g?�䧿���'�So?��ә�Rۃ���7�����}�[����������[�V���?���&�q��q�5�cm�Ml��z��X")�o�^��D���F���fBQO"%���G��K.)Т(z�A�9��� ����4H� IAm�=�}��4�F3Ҍwg6����{|�{|���������U�4��[�w�l�Y:�O<�������\������:�et����_��������}z��:�^-K��:����S�i�3gv3�s�.v��|�*r�� W��(?Ӿ�^��a��'g����C����D*}�؎H��V/�݋��d����~�m��TlXI��B��Tw�qI���^�����n$T��V⸏u�\��?�1�J�։N�9=�/�c�}9:�����������?Ɔ���h��DD˹j.����rQ������9ȯ�ߎW���P�t���m*��R�Zd���AMT�����R��v!0�4&a����{��j��kq�f��F���A<��I��<���3���ur�N�M���r�Fq�̹��;�r��y���ku���8+��q�q��V\ c/�ʒVM��(�	�X*[ة��i
��J�,k�L)���L�+�A;g���$�
��v�\-/'0��gM��V�L��dI!�X>n&+|D	�<y��./�N+v���Vr�L�����>�I=aX̡�4����l2.��=>"AV�XL����д�C��V���vr�|�S�r�Rb��x()%�=!��/�!-�3��]X,����^�h'��cAϨ�x��Y.��m��Ę�pIPR\-j���V��x������ֳ��J(��;�F-���\l��%9W3��L2�Ջ-,���B�[Q��Ų� {�bI�6�2��83� �S꼺�gD"$e%Sj5�e{9����2�����)�Fw騞)$�0��+��V�J�š��bl��.����2\�X��/���%Ť����ݦPc	�����8����_h[c��רG�dX+������9VK����{f~�<l�ٮp��9:-w�<���[,�X���(�}�P�
�d�H�+�B�>�X��`�\,��6�"`����0�>��dn0���a��c��`5����Pt������q(V=]0cr-�wc1Y-��a����¾�-��X<����l�ζ��v�}G��0سe�Cc����_��;�"��?�>u�K�_Ŀ:oJ�7��y�Flr�����sm���� o�����u�\�7�"�����װ��>���GS��ob_�a�R�����?�}��z�$��C���l�sQ�%a��{��������
�LV���Y�7������20L]l�5~m��b�P˨�4�o��`O���f�s2m_�_��e��ٍ9��,���A��ﭧf0�b/E����R��yϛ��������z{��48n��x�G���9R~�_��ˎ��[�o����:�t�:W��X��x��^�B%5�=������B���D��(rj���檎,�%u**O��h~�qqp�
� �\B�z*���J�)V�#��њ��anFYH^��[��%���#bQ;Ί�DTE��"K�f�t�ڡKܱf1d�(�R�T&�Ʋ�Z?Av�F��XU폹�hJ�僢Lg�m.U���˂��d>̱z�Q#�j�/D�I�?�38H��d{t����&� mȜ��`49�?M��Ԇ��\l��F��$EVKy:3���di�n皻j}�8�scI���,�Ga�6� �a�`/ٷ���:���[�=.q�����j�uj*� �z �ƃ��a�W4�ÿ�������~8ӄ���m�P�����<ҋ&�̬=��n�A�W���??kp���N���f�̔���E��i�W�i���Ϗ�uSaR�}�'�$bZ���G���NM�����꩏����zf�1&�s`nN��慌��lӏ�,}�g*���~�g��$��gʾ3,l� � ���L��ƙm�;�O� ��"I^��3�.��k��qL�ҩ8�Ć��`'!��h��OǄ�R:�1�}u���� ��G�96����j��9��3g��v]���1%�D���� 3%�X�K�%و�Q̊���l%5>�����Gr%i/QꦭR$*�Z���/�5�amT4FTY��
I	T��1B�Zw{<c���&QE�wZ��\u����aY��ڍ@�]2��4 �%��5-�8\�����������������&�z=��m���+4��憻�k��Ml+����Y�������װg*)��fۋ�j����OTL�LK�=��������&^S��ԁa ��K��L;�v�
R�ۧ|�Q8�O�O�_���7���]þ���'�\8��7߹�n��������o r�?��`��b���5�4�����|n������� �ڡa��wx�d­p��GA0;|0��ZDBM: �i! 0l 8�=����|�������?{�U��������ӣ�����`�d��N�� ���\���y�_-&���Mu�D�$Q7��M8p�D]���t�	�l7I�Mu�D]���ٞ�$�+���T>�&��oc/.�|�_[����<7IU}i���c�-��~r��\b�K��\�(ps�p��us\�p���2\E��%�����uVn��/�����rܭ��w_�K.q<�}9W�e�;y�0��Ѧpn�H���1e�b�̮_~�_~����?�s?�����������??���s�xwޞ���ǝ��Ųi�'ʒ4v��/�ǚ��P`���~�O��?\Iy�M�!)d�!{����I�
ђt�$����{��K�I�Lj��+MÇ�$����$u�A��!K��lJ:LU�.|X<]���!4	��(|���Q��:���1�.u����y��Mx���M��<��Ґ1�	�2н���u�\��z2�T�e�Z�m�x8K-U'R#�2h��N8�A�*a�
����W[�D�@
�[�Y>!�9�f�=B2`���I$�h9;�T�r����q���d^G=)V��1 �*q��*��!��Y��Ch�yqN��x;�����-������Ăd#�1K�E�JS œI"�φ�Å4r�ͮ*M:G38��Z\:���qұ�Ib���^\�]5'}����[�����Z�������#}�G��b�����&�Q�Ֆ$�%�z�����?����*�g��z���-⻤o�:�� 
���^�Y(�U�����]0�P@ X{����>�8y1y��B�Ax�ͺ��$>���
	���<��uU��c,�1�m�cy�snN�7�w�;��'<�.{��5�6IB��eQ5L�x�6��3�~�ijˠ�i7�i,�Aܟ]� :8��a�3���<k�PX�Ӏ����w�~C�72���<��R��
Z/����B�{����36�p�\�u=CK�Q��?������P����PԴRR�j�WҰ{����bϼ:0e��uK��A4 T �U޴$+V(}�GA��&E �G)6��U�����?�e��P�����<��?Q-����N�By��K
\��.d�=�-����Hȣ���[m@\�@t�y�غ�S�y�>��?�|��J��{��U����ibش������?M���*J _�����P͑z|�&�-��j8��`�Eaܶ�"/q驶�zޙH���B��%]Uz�1ߞ)w^"��\�R�Ŏb����l4���k��h!�xB��~k�m���w���c���V!�%b�2wT�����J�ݫ�\��Umt��j98�x���W�X�4�*.��u��	�d��5���t>y��j\�N���%Ou��߁3r�v1�>���bw��(z)+����V6��p��r�z��� (�Y8t|��Ґ����2W��h�J�ci�*��%�;{�Km� �in9~�����EQ���ϡ��We�f�Y��n������!�����"�|��V�:�����������H��Ϡ��V��|�Nޕ j��E��q �}т���oۣ@~y8�Vyy�mY4��j��
��@�5���B/�&���j�F�C:�^�"ٜ�M��h��O����]IyR���?u�#�=���"��q�Z��kɀzŀd�+��zjE�v`(&�1uNў�c'.�IX��ԩ�-ޒ�I���I;4�K�xـ ���������-����K�WR�x��$ȍ���
h�H�j����ߎ�^oÒ�&ak�id���4���"��7	E f�����.��5��!� �F�
8�s�f��M��sԃ�����u�_��P���WR&��P��,�zxx��ŉ��_0�EW�(iHm� �s���"�Nd5e5��	������Hz������~�����̱���5/���?E�K��O�]�%�-�R�/�Vm�	u��߿Kb��r�� ��?��,�t���^Iy���%��|������
��x��|�H�}(}����A��b�!�ѡ0��p���d�x)"���b��{����|�ϱ!�5���IM
�Po�h��Sr��b.v�#��a�@V5o'���f鈪'@ԇ�Ŕ�[�e��nw|ҁ-C�J1��p1���w*��3P��I"����'�Sd�fLE�-�Ca(��d�P�-$H 5�Xw��x� Ko�⁳CyyYy��*��%�= �"��6�����n=I|ҵ���� J}%Oے5��ElS�g�|_2Ht�ɳ�D�WAڝ3����]o{,9U�/������,�L��`���%��W�[��
����(��y�g�u������v���+)�[&~�~��'���L������tU�`�������t�+���;�A��I3��#�<�Ew���9��JR��Kx�'��j\��.䷇�{�#T�p��"y��{oVu�����6�Mܙl��l�����e(o�X��ȶ�U�.l�;��U��A����4�uj�{�3��up�ַ�Rޝ{�7��8����ݻč���.qCĽ{�K����m"�B{b���C|x��>r7��ڢ9Y3��	] �L�,�{ɞ�,/�Y\E_ �
��D�3�:���/���p�q��]I�����@\�a��_��\���Y>��������2��{���U���m񞴻޳*�5mv�m�l�`ό�vvY׎sq|�;	T0�Ǘ�2Ό���e	!��
B}�*�J<�(<A �x�jWB��E�b� ���q�u��뭚����>7����|��(�����g��=S*�=�BAz�-\:W�Ӳ���jOv��]��(��]1��")��Fx�o���=��O�y9�p��Sv�n��]M����G�=����jI�T)��
KZ�2;L=0�u�Q����J����"B�곓�D	��ٽ��:��I��� ��Vk;�������e'`?V����:�Q�����SiYy��P����ީ���S���΃���� 1���UH�~}y�)"��D����gL-��Y�=h��l�S�sw��պ���Gm�o���g����&K|�ةvO���I�s�<:�U��!{V�eT���9֊S]�w�4~#W����ƥZ�^k����Vs��<�/]6*�j��W��'���\�KV�Z6�����E\#�H��N*��Pɒ�U�u�X���*wf����%ɥ��mZ��.=<ez�&S{V)�������bRs�-9f���v�==�թ��_A�TN�i�s"+��K<��#�������8D����h ������Go�E�N%�gwRNF�H�OK��������L�NZ3��?/��Q�i}IL]�&Ӕ�gI	��,Kn3�+�rє{�a9z�e��t�ngng�t$]dґ��RE��S����}��/�i�b:���/�z�K/|�S/��3�� �@�N-��O�����z�V��%�R �}���qU#��8��8~u����(��ܑeRr=eR�;u�ZMW�D����%�
���٣�ٗ �;vC�l��D����uox�g۶QK�-*[mL'l��z�OQIWb�_�^mF��J�� �[|m=�v�&���ڙ���8�&�⍳��]T�O���`ڶXsgE��\�'���V��*nd|�յF��OG62v��������k��J~3��S��I�2K���a/�~і	�˛��X6��f& Dʶ0��l�����-<Z��%Z�}iɂ�'H}�/�	�e�Zַj�_,K�K��b��^,;},�Ez��E�g9���~?�bQ&�6H:ԤjS,�o'܌�U^帒'�ݳ¼����/�WB��V�]�'wij�\*���C�`�e>���f�xf��jl+%�-�=�;��w�D}�6��ts�eV�Ճ�M!c�k�چ+�����:������Π(7�/�No�.�d�[�;�G3��β[d#D9��|����lು�֟Ϧ<�m��I<n:�-��3�q㫴^ɡ+GMaB*�����1�1���mݪ���\F�?�V�Y��Z����Уc/�U��Cg�_�$���s�t�,��y�SX�Ċ�S6�Dl2t��W��+�Uq�QV��)�/�z+:��&�kr�I<fB�7�$/ܼI$�5��*�Fq��K)#�%�5�/�����\�ޚh�Ӓ����/�Zפ�ˮ���H�i����R � q�GT�� �8n�1��,9��lG�~p����aQzX���Z״�_�z{X�H<,��}p"i q� q~D����@�����)�v�:jK龏0�e]T�v>��.��L�U�jR�7K�������f-��I�N9Q�����`��2k�z
^�	�"�؄�-z(�9�`_��ܾ8�<$��q
�ď�n�ҙ]�|�7��Ko=�I2��o�y���_�❿��ߏ��b.Sb��j_>l������
U姇�ǁ�O����dH�?Gd�o�����q罱��s������׿q�o�_�����?�8����^_A�^A.t�tB�ߛ~�pE��ڔ��r)l��[�쉏���B�w�'?mu���p����������� ��������v��N�v�h@ j'���wq! i�v���ು��~�v̷!tj Re?4P���C�\�[�D��n��V�!C�o21�5���{ȟ?��wԄ�x��� �Ra+x``�gp��!X� 3���]C���<-ș�h+��@Z �@��rf��{��Qd�L;7@h�_��%���9,~�>A&��                 ����2̬#   