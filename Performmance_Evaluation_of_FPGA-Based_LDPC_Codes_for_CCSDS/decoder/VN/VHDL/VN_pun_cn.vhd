-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.1 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity VN_pun_cn_rom is 
    generic(
             DWIDTH     : integer := 1; 
             AWIDTH     : integer := 13; 
             MEM_SIZE    : integer := 7680
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of VN_pun_cn_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 to 4612=> "1", 4613 => "0", 4614 to 4618=> "1", 4619 => "0", 4620 to 4624=> "1", 4625 => "0", 4626 to 4630=> "1", 
    4631 => "0", 4632 to 4636=> "1", 4637 => "0", 4638 to 4642=> "1", 4643 => "0", 4644 to 4648=> "1", 4649 => "0", 
    4650 to 4654=> "1", 4655 => "0", 4656 to 4660=> "1", 4661 => "0", 4662 to 4666=> "1", 4667 => "0", 4668 to 4672=> "1", 
    4673 => "0", 4674 to 4678=> "1", 4679 => "0", 4680 to 4684=> "1", 4685 => "0", 4686 to 4690=> "1", 4691 => "0", 
    4692 to 4696=> "1", 4697 => "0", 4698 to 4702=> "1", 4703 => "0", 4704 to 4708=> "1", 4709 => "0", 4710 to 4714=> "1", 
    4715 => "0", 4716 to 4720=> "1", 4721 => "0", 4722 to 4726=> "1", 4727 => "0", 4728 to 4732=> "1", 4733 => "0", 
    4734 to 4738=> "1", 4739 => "0", 4740 to 4744=> "1", 4745 => "0", 4746 to 4750=> "1", 4751 => "0", 4752 to 4756=> "1", 
    4757 => "0", 4758 to 4762=> "1", 4763 => "0", 4764 to 4768=> "1", 4769 => "0", 4770 to 4774=> "1", 4775 => "0", 
    4776 to 4780=> "1", 4781 => "0", 4782 to 4786=> "1", 4787 => "0", 4788 to 4792=> "1", 4793 => "0", 4794 to 4798=> "1", 
    4799 => "0", 4800 to 4804=> "1", 4805 => "0", 4806 to 4810=> "1", 4811 => "0", 4812 to 4816=> "1", 4817 => "0", 
    4818 to 4822=> "1", 4823 => "0", 4824 to 4828=> "1", 4829 => "0", 4830 to 4834=> "1", 4835 => "0", 4836 to 4840=> "1", 
    4841 => "0", 4842 to 4846=> "1", 4847 => "0", 4848 to 4852=> "1", 4853 => "0", 4854 to 4858=> "1", 4859 => "0", 
    4860 to 4864=> "1", 4865 => "0", 4866 to 4870=> "1", 4871 => "0", 4872 to 4876=> "1", 4877 => "0", 4878 to 4882=> "1", 
    4883 => "0", 4884 to 4888=> "1", 4889 => "0", 4890 to 4894=> "1", 4895 => "0", 4896 to 4900=> "1", 4901 => "0", 
    4902 to 4906=> "1", 4907 => "0", 4908 to 4912=> "1", 4913 => "0", 4914 to 4918=> "1", 4919 => "0", 4920 to 4924=> "1", 
    4925 => "0", 4926 to 4930=> "1", 4931 => "0", 4932 to 4936=> "1", 4937 => "0", 4938 to 4942=> "1", 4943 => "0", 
    4944 to 4948=> "1", 4949 => "0", 4950 to 4954=> "1", 4955 => "0", 4956 to 4960=> "1", 4961 => "0", 4962 to 4966=> "1", 
    4967 => "0", 4968 to 4972=> "1", 4973 => "0", 4974 to 4978=> "1", 4979 => "0", 4980 to 4984=> "1", 4985 => "0", 
    4986 to 4990=> "1", 4991 => "0", 4992 to 4996=> "1", 4997 => "0", 4998 to 5002=> "1", 5003 => "0", 5004 to 5008=> "1", 
    5009 => "0", 5010 to 5014=> "1", 5015 => "0", 5016 to 5020=> "1", 5021 => "0", 5022 to 5026=> "1", 5027 => "0", 
    5028 to 5032=> "1", 5033 => "0", 5034 to 5038=> "1", 5039 => "0", 5040 to 5044=> "1", 5045 => "0", 5046 to 5050=> "1", 
    5051 => "0", 5052 to 5056=> "1", 5057 => "0", 5058 to 5062=> "1", 5063 => "0", 5064 to 5068=> "1", 5069 => "0", 
    5070 to 5074=> "1", 5075 => "0", 5076 to 5080=> "1", 5081 => "0", 5082 to 5086=> "1", 5087 => "0", 5088 to 5092=> "1", 
    5093 => "0", 5094 to 5098=> "1", 5099 => "0", 5100 to 5104=> "1", 5105 => "0", 5106 to 5110=> "1", 5111 => "0", 
    5112 to 5116=> "1", 5117 => "0", 5118 to 5122=> "1", 5123 => "0", 5124 to 5128=> "1", 5129 => "0", 5130 to 5134=> "1", 
    5135 => "0", 5136 to 5140=> "1", 5141 => "0", 5142 to 5146=> "1", 5147 => "0", 5148 to 5152=> "1", 5153 => "0", 
    5154 to 5158=> "1", 5159 => "0", 5160 to 5164=> "1", 5165 => "0", 5166 to 5170=> "1", 5171 => "0", 5172 to 5176=> "1", 
    5177 => "0", 5178 to 5182=> "1", 5183 => "0", 5184 to 5188=> "1", 5189 => "0", 5190 to 5194=> "1", 5195 => "0", 
    5196 to 5200=> "1", 5201 => "0", 5202 to 5206=> "1", 5207 => "0", 5208 to 5212=> "1", 5213 => "0", 5214 to 5218=> "1", 
    5219 => "0", 5220 to 5224=> "1", 5225 => "0", 5226 to 5230=> "1", 5231 => "0", 5232 to 5236=> "1", 5237 => "0", 
    5238 to 5242=> "1", 5243 => "0", 5244 to 5248=> "1", 5249 => "0", 5250 to 5254=> "1", 5255 => "0", 5256 to 5260=> "1", 
    5261 => "0", 5262 to 5266=> "1", 5267 => "0", 5268 to 5272=> "1", 5273 => "0", 5274 to 5278=> "1", 5279 => "0", 
    5280 to 5284=> "1", 5285 => "0", 5286 to 5290=> "1", 5291 => "0", 5292 to 5296=> "1", 5297 => "0", 5298 to 5302=> "1", 
    5303 => "0", 5304 to 5308=> "1", 5309 => "0", 5310 to 5314=> "1", 5315 => "0", 5316 to 5320=> "1", 5321 => "0", 
    5322 to 5326=> "1", 5327 => "0", 5328 to 5332=> "1", 5333 => "0", 5334 to 5338=> "1", 5339 => "0", 5340 to 5344=> "1", 
    5345 => "0", 5346 to 5350=> "1", 5351 => "0", 5352 to 5356=> "1", 5357 => "0", 5358 to 5362=> "1", 5363 => "0", 
    5364 to 5368=> "1", 5369 => "0", 5370 to 5374=> "1", 5375 => "0", 5376 to 5380=> "1", 5381 => "0", 5382 to 5386=> "1", 
    5387 => "0", 5388 to 5392=> "1", 5393 => "0", 5394 to 5398=> "1", 5399 => "0", 5400 to 5404=> "1", 5405 => "0", 
    5406 to 5410=> "1", 5411 => "0", 5412 to 5416=> "1", 5417 => "0", 5418 to 5422=> "1", 5423 => "0", 5424 to 5428=> "1", 
    5429 => "0", 5430 to 5434=> "1", 5435 => "0", 5436 to 5440=> "1", 5441 => "0", 5442 to 5446=> "1", 5447 => "0", 
    5448 to 5452=> "1", 5453 => "0", 5454 to 5458=> "1", 5459 => "0", 5460 to 5464=> "1", 5465 => "0", 5466 to 5470=> "1", 
    5471 => "0", 5472 to 5476=> "1", 5477 => "0", 5478 to 5482=> "1", 5483 => "0", 5484 to 5488=> "1", 5489 => "0", 
    5490 to 5494=> "1", 5495 => "0", 5496 to 5500=> "1", 5501 => "0", 5502 to 5506=> "1", 5507 => "0", 5508 to 5512=> "1", 
    5513 => "0", 5514 to 5518=> "1", 5519 => "0", 5520 to 5524=> "1", 5525 => "0", 5526 to 5530=> "1", 5531 => "0", 
    5532 to 5536=> "1", 5537 => "0", 5538 to 5542=> "1", 5543 => "0", 5544 to 5548=> "1", 5549 => "0", 5550 to 5554=> "1", 
    5555 => "0", 5556 to 5560=> "1", 5561 => "0", 5562 to 5566=> "1", 5567 => "0", 5568 to 5572=> "1", 5573 => "0", 
    5574 to 5578=> "1", 5579 => "0", 5580 to 5584=> "1", 5585 => "0", 5586 to 5590=> "1", 5591 => "0", 5592 to 5596=> "1", 
    5597 => "0", 5598 to 5602=> "1", 5603 => "0", 5604 to 5608=> "1", 5609 => "0", 5610 to 5614=> "1", 5615 => "0", 
    5616 to 5620=> "1", 5621 => "0", 5622 to 5626=> "1", 5627 => "0", 5628 to 5632=> "1", 5633 => "0", 5634 to 5638=> "1", 
    5639 => "0", 5640 to 5644=> "1", 5645 => "0", 5646 to 5650=> "1", 5651 => "0", 5652 to 5656=> "1", 5657 => "0", 
    5658 to 5662=> "1", 5663 => "0", 5664 to 5668=> "1", 5669 => "0", 5670 to 5674=> "1", 5675 => "0", 5676 to 5680=> "1", 
    5681 => "0", 5682 to 5686=> "1", 5687 => "0", 5688 to 5692=> "1", 5693 => "0", 5694 to 5698=> "1", 5699 => "0", 
    5700 to 5704=> "1", 5705 => "0", 5706 to 5710=> "1", 5711 => "0", 5712 to 5716=> "1", 5717 => "0", 5718 to 5722=> "1", 
    5723 => "0", 5724 to 5728=> "1", 5729 => "0", 5730 to 5734=> "1", 5735 => "0", 5736 to 5740=> "1", 5741 => "0", 
    5742 to 5746=> "1", 5747 => "0", 5748 to 5752=> "1", 5753 => "0", 5754 to 5758=> "1", 5759 => "0", 5760 to 5764=> "1", 
    5765 => "0", 5766 to 5770=> "1", 5771 => "0", 5772 to 5776=> "1", 5777 => "0", 5778 to 5782=> "1", 5783 => "0", 
    5784 to 5788=> "1", 5789 => "0", 5790 to 5794=> "1", 5795 => "0", 5796 to 5800=> "1", 5801 => "0", 5802 to 5806=> "1", 
    5807 => "0", 5808 to 5812=> "1", 5813 => "0", 5814 to 5818=> "1", 5819 => "0", 5820 to 5824=> "1", 5825 => "0", 
    5826 to 5830=> "1", 5831 => "0", 5832 to 5836=> "1", 5837 => "0", 5838 to 5842=> "1", 5843 => "0", 5844 to 5848=> "1", 
    5849 => "0", 5850 to 5854=> "1", 5855 => "0", 5856 to 5860=> "1", 5861 => "0", 5862 to 5866=> "1", 5867 => "0", 
    5868 to 5872=> "1", 5873 => "0", 5874 to 5878=> "1", 5879 => "0", 5880 to 5884=> "1", 5885 => "0", 5886 to 5890=> "1", 
    5891 => "0", 5892 to 5896=> "1", 5897 => "0", 5898 to 5902=> "1", 5903 => "0", 5904 to 5908=> "1", 5909 => "0", 
    5910 to 5914=> "1", 5915 => "0", 5916 to 5920=> "1", 5921 => "0", 5922 to 5926=> "1", 5927 => "0", 5928 to 5932=> "1", 
    5933 => "0", 5934 to 5938=> "1", 5939 => "0", 5940 to 5944=> "1", 5945 => "0", 5946 to 5950=> "1", 5951 => "0", 
    5952 to 5956=> "1", 5957 => "0", 5958 to 5962=> "1", 5963 => "0", 5964 to 5968=> "1", 5969 => "0", 5970 to 5974=> "1", 
    5975 => "0", 5976 to 5980=> "1", 5981 => "0", 5982 to 5986=> "1", 5987 => "0", 5988 to 5992=> "1", 5993 => "0", 
    5994 to 5998=> "1", 5999 => "0", 6000 to 6004=> "1", 6005 => "0", 6006 to 6010=> "1", 6011 => "0", 6012 to 6016=> "1", 
    6017 => "0", 6018 to 6022=> "1", 6023 => "0", 6024 to 6028=> "1", 6029 => "0", 6030 to 6034=> "1", 6035 => "0", 
    6036 to 6040=> "1", 6041 => "0", 6042 to 6046=> "1", 6047 => "0", 6048 to 6052=> "1", 6053 => "0", 6054 to 6058=> "1", 
    6059 => "0", 6060 to 6064=> "1", 6065 => "0", 6066 to 6070=> "1", 6071 => "0", 6072 to 6076=> "1", 6077 => "0", 
    6078 to 6082=> "1", 6083 => "0", 6084 to 6088=> "1", 6089 => "0", 6090 to 6094=> "1", 6095 => "0", 6096 to 6100=> "1", 
    6101 => "0", 6102 to 6106=> "1", 6107 => "0", 6108 to 6112=> "1", 6113 => "0", 6114 to 6118=> "1", 6119 => "0", 
    6120 to 6124=> "1", 6125 => "0", 6126 to 6130=> "1", 6131 => "0", 6132 to 6136=> "1", 6137 => "0", 6138 to 6142=> "1", 
    6143 => "0", 6144 to 6148=> "1", 6149 => "0", 6150 to 6154=> "1", 6155 => "0", 6156 to 6160=> "1", 6161 => "0", 
    6162 to 6166=> "1", 6167 => "0", 6168 to 6172=> "1", 6173 => "0", 6174 to 6178=> "1", 6179 => "0", 6180 to 6184=> "1", 
    6185 => "0", 6186 to 6190=> "1", 6191 => "0", 6192 to 6196=> "1", 6197 => "0", 6198 to 6202=> "1", 6203 => "0", 
    6204 to 6208=> "1", 6209 => "0", 6210 to 6214=> "1", 6215 => "0", 6216 to 6220=> "1", 6221 => "0", 6222 to 6226=> "1", 
    6227 => "0", 6228 to 6232=> "1", 6233 => "0", 6234 to 6238=> "1", 6239 => "0", 6240 to 6244=> "1", 6245 => "0", 
    6246 to 6250=> "1", 6251 => "0", 6252 to 6256=> "1", 6257 => "0", 6258 to 6262=> "1", 6263 => "0", 6264 to 6268=> "1", 
    6269 => "0", 6270 to 6274=> "1", 6275 => "0", 6276 to 6280=> "1", 6281 => "0", 6282 to 6286=> "1", 6287 => "0", 
    6288 to 6292=> "1", 6293 => "0", 6294 to 6298=> "1", 6299 => "0", 6300 to 6304=> "1", 6305 => "0", 6306 to 6310=> "1", 
    6311 => "0", 6312 to 6316=> "1", 6317 => "0", 6318 to 6322=> "1", 6323 => "0", 6324 to 6328=> "1", 6329 => "0", 
    6330 to 6334=> "1", 6335 => "0", 6336 to 6340=> "1", 6341 => "0", 6342 to 6346=> "1", 6347 => "0", 6348 to 6352=> "1", 
    6353 => "0", 6354 to 6358=> "1", 6359 => "0", 6360 to 6364=> "1", 6365 => "0", 6366 to 6370=> "1", 6371 => "0", 
    6372 to 6376=> "1", 6377 => "0", 6378 to 6382=> "1", 6383 => "0", 6384 to 6388=> "1", 6389 => "0", 6390 to 6394=> "1", 
    6395 => "0", 6396 to 6400=> "1", 6401 => "0", 6402 to 6406=> "1", 6407 => "0", 6408 to 6412=> "1", 6413 => "0", 
    6414 to 6418=> "1", 6419 => "0", 6420 to 6424=> "1", 6425 => "0", 6426 to 6430=> "1", 6431 => "0", 6432 to 6436=> "1", 
    6437 => "0", 6438 to 6442=> "1", 6443 => "0", 6444 to 6448=> "1", 6449 => "0", 6450 to 6454=> "1", 6455 => "0", 
    6456 to 6460=> "1", 6461 => "0", 6462 to 6466=> "1", 6467 => "0", 6468 to 6472=> "1", 6473 => "0", 6474 to 6478=> "1", 
    6479 => "0", 6480 to 6484=> "1", 6485 => "0", 6486 to 6490=> "1", 6491 => "0", 6492 to 6496=> "1", 6497 => "0", 
    6498 to 6502=> "1", 6503 => "0", 6504 to 6508=> "1", 6509 => "0", 6510 to 6514=> "1", 6515 => "0", 6516 to 6520=> "1", 
    6521 => "0", 6522 to 6526=> "1", 6527 => "0", 6528 to 6532=> "1", 6533 => "0", 6534 to 6538=> "1", 6539 => "0", 
    6540 to 6544=> "1", 6545 => "0", 6546 to 6550=> "1", 6551 => "0", 6552 to 6556=> "1", 6557 => "0", 6558 to 6562=> "1", 
    6563 => "0", 6564 to 6568=> "1", 6569 => "0", 6570 to 6574=> "1", 6575 => "0", 6576 to 6580=> "1", 6581 => "0", 
    6582 to 6586=> "1", 6587 => "0", 6588 to 6592=> "1", 6593 => "0", 6594 to 6598=> "1", 6599 => "0", 6600 to 6604=> "1", 
    6605 => "0", 6606 to 6610=> "1", 6611 => "0", 6612 to 6616=> "1", 6617 => "0", 6618 to 6622=> "1", 6623 => "0", 
    6624 to 6628=> "1", 6629 => "0", 6630 to 6634=> "1", 6635 => "0", 6636 to 6640=> "1", 6641 => "0", 6642 to 6646=> "1", 
    6647 => "0", 6648 to 6652=> "1", 6653 => "0", 6654 to 6658=> "1", 6659 => "0", 6660 to 6664=> "1", 6665 => "0", 
    6666 to 6670=> "1", 6671 => "0", 6672 to 6676=> "1", 6677 => "0", 6678 to 6682=> "1", 6683 => "0", 6684 to 6688=> "1", 
    6689 => "0", 6690 to 6694=> "1", 6695 => "0", 6696 to 6700=> "1", 6701 => "0", 6702 to 6706=> "1", 6707 => "0", 
    6708 to 6712=> "1", 6713 => "0", 6714 to 6718=> "1", 6719 => "0", 6720 to 6724=> "1", 6725 => "0", 6726 to 6730=> "1", 
    6731 => "0", 6732 to 6736=> "1", 6737 => "0", 6738 to 6742=> "1", 6743 => "0", 6744 to 6748=> "1", 6749 => "0", 
    6750 to 6754=> "1", 6755 => "0", 6756 to 6760=> "1", 6761 => "0", 6762 to 6766=> "1", 6767 => "0", 6768 to 6772=> "1", 
    6773 => "0", 6774 to 6778=> "1", 6779 => "0", 6780 to 6784=> "1", 6785 => "0", 6786 to 6790=> "1", 6791 => "0", 
    6792 to 6796=> "1", 6797 => "0", 6798 to 6802=> "1", 6803 => "0", 6804 to 6808=> "1", 6809 => "0", 6810 to 6814=> "1", 
    6815 => "0", 6816 to 6820=> "1", 6821 => "0", 6822 to 6826=> "1", 6827 => "0", 6828 to 6832=> "1", 6833 => "0", 
    6834 to 6838=> "1", 6839 => "0", 6840 to 6844=> "1", 6845 => "0", 6846 to 6850=> "1", 6851 => "0", 6852 to 6856=> "1", 
    6857 => "0", 6858 to 6862=> "1", 6863 => "0", 6864 to 6868=> "1", 6869 => "0", 6870 to 6874=> "1", 6875 => "0", 
    6876 to 6880=> "1", 6881 => "0", 6882 to 6886=> "1", 6887 => "0", 6888 to 6892=> "1", 6893 => "0", 6894 to 6898=> "1", 
    6899 => "0", 6900 to 6904=> "1", 6905 => "0", 6906 to 6910=> "1", 6911 => "0", 6912 to 6916=> "1", 6917 => "0", 
    6918 to 6922=> "1", 6923 => "0", 6924 to 6928=> "1", 6929 => "0", 6930 to 6934=> "1", 6935 => "0", 6936 to 6940=> "1", 
    6941 => "0", 6942 to 6946=> "1", 6947 => "0", 6948 to 6952=> "1", 6953 => "0", 6954 to 6958=> "1", 6959 => "0", 
    6960 to 6964=> "1", 6965 => "0", 6966 to 6970=> "1", 6971 => "0", 6972 to 6976=> "1", 6977 => "0", 6978 to 6982=> "1", 
    6983 => "0", 6984 to 6988=> "1", 6989 => "0", 6990 to 6994=> "1", 6995 => "0", 6996 to 7000=> "1", 7001 => "0", 
    7002 to 7006=> "1", 7007 => "0", 7008 to 7012=> "1", 7013 => "0", 7014 to 7018=> "1", 7019 => "0", 7020 to 7024=> "1", 
    7025 => "0", 7026 to 7030=> "1", 7031 => "0", 7032 to 7036=> "1", 7037 => "0", 7038 to 7042=> "1", 7043 => "0", 
    7044 to 7048=> "1", 7049 => "0", 7050 to 7054=> "1", 7055 => "0", 7056 to 7060=> "1", 7061 => "0", 7062 to 7066=> "1", 
    7067 => "0", 7068 to 7072=> "1", 7073 => "0", 7074 to 7078=> "1", 7079 => "0", 7080 to 7084=> "1", 7085 => "0", 
    7086 to 7090=> "1", 7091 => "0", 7092 to 7096=> "1", 7097 => "0", 7098 to 7102=> "1", 7103 => "0", 7104 to 7108=> "1", 
    7109 => "0", 7110 to 7114=> "1", 7115 => "0", 7116 to 7120=> "1", 7121 => "0", 7122 to 7126=> "1", 7127 => "0", 
    7128 to 7132=> "1", 7133 => "0", 7134 to 7138=> "1", 7139 => "0", 7140 to 7144=> "1", 7145 => "0", 7146 to 7150=> "1", 
    7151 => "0", 7152 to 7156=> "1", 7157 => "0", 7158 to 7162=> "1", 7163 => "0", 7164 to 7168=> "1", 7169 => "0", 
    7170 to 7174=> "1", 7175 => "0", 7176 to 7180=> "1", 7181 => "0", 7182 to 7186=> "1", 7187 => "0", 7188 to 7192=> "1", 
    7193 => "0", 7194 to 7198=> "1", 7199 => "0", 7200 to 7204=> "1", 7205 => "0", 7206 to 7210=> "1", 7211 => "0", 
    7212 to 7216=> "1", 7217 => "0", 7218 to 7222=> "1", 7223 => "0", 7224 to 7228=> "1", 7229 => "0", 7230 to 7234=> "1", 
    7235 => "0", 7236 to 7240=> "1", 7241 => "0", 7242 to 7246=> "1", 7247 => "0", 7248 to 7252=> "1", 7253 => "0", 
    7254 to 7258=> "1", 7259 => "0", 7260 to 7264=> "1", 7265 => "0", 7266 to 7270=> "1", 7271 => "0", 7272 to 7276=> "1", 
    7277 => "0", 7278 to 7282=> "1", 7283 => "0", 7284 to 7288=> "1", 7289 => "0", 7290 to 7294=> "1", 7295 => "0", 
    7296 to 7300=> "1", 7301 => "0", 7302 to 7306=> "1", 7307 => "0", 7308 to 7312=> "1", 7313 => "0", 7314 to 7318=> "1", 
    7319 => "0", 7320 to 7324=> "1", 7325 => "0", 7326 to 7330=> "1", 7331 => "0", 7332 to 7336=> "1", 7337 => "0", 
    7338 to 7342=> "1", 7343 => "0", 7344 to 7348=> "1", 7349 => "0", 7350 to 7354=> "1", 7355 => "0", 7356 to 7360=> "1", 
    7361 => "0", 7362 to 7366=> "1", 7367 => "0", 7368 to 7372=> "1", 7373 => "0", 7374 to 7378=> "1", 7379 => "0", 
    7380 to 7384=> "1", 7385 => "0", 7386 to 7390=> "1", 7391 => "0", 7392 to 7396=> "1", 7397 => "0", 7398 to 7402=> "1", 
    7403 => "0", 7404 to 7408=> "1", 7409 => "0", 7410 to 7414=> "1", 7415 => "0", 7416 to 7420=> "1", 7421 => "0", 
    7422 to 7426=> "1", 7427 => "0", 7428 to 7432=> "1", 7433 => "0", 7434 to 7438=> "1", 7439 => "0", 7440 to 7444=> "1", 
    7445 => "0", 7446 to 7450=> "1", 7451 => "0", 7452 to 7456=> "1", 7457 => "0", 7458 to 7462=> "1", 7463 => "0", 
    7464 to 7468=> "1", 7469 => "0", 7470 to 7474=> "1", 7475 => "0", 7476 to 7480=> "1", 7481 => "0", 7482 to 7486=> "1", 
    7487 => "0", 7488 to 7492=> "1", 7493 => "0", 7494 to 7498=> "1", 7499 => "0", 7500 to 7504=> "1", 7505 => "0", 
    7506 to 7510=> "1", 7511 => "0", 7512 to 7516=> "1", 7517 => "0", 7518 to 7522=> "1", 7523 => "0", 7524 to 7528=> "1", 
    7529 => "0", 7530 to 7534=> "1", 7535 => "0", 7536 to 7540=> "1", 7541 => "0", 7542 to 7546=> "1", 7547 => "0", 
    7548 to 7552=> "1", 7553 => "0", 7554 to 7558=> "1", 7559 => "0", 7560 to 7564=> "1", 7565 => "0", 7566 to 7570=> "1", 
    7571 => "0", 7572 to 7576=> "1", 7577 => "0", 7578 to 7582=> "1", 7583 => "0", 7584 to 7588=> "1", 7589 => "0", 
    7590 to 7594=> "1", 7595 => "0", 7596 to 7600=> "1", 7601 => "0", 7602 to 7606=> "1", 7607 => "0", 7608 to 7612=> "1", 
    7613 => "0", 7614 to 7618=> "1", 7619 => "0", 7620 to 7624=> "1", 7625 => "0", 7626 to 7630=> "1", 7631 => "0", 
    7632 to 7636=> "1", 7637 => "0", 7638 to 7642=> "1", 7643 => "0", 7644 to 7648=> "1", 7649 => "0", 7650 to 7654=> "1", 
    7655 => "0", 7656 to 7660=> "1", 7661 => "0", 7662 to 7666=> "1", 7667 => "0", 7668 to 7672=> "1", 7673 => "0", 
    7674 to 7678=> "1", 7679 => "0" );


begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity VN_pun_cn is
    generic (
        DataWidth : INTEGER := 1;
        AddressRange : INTEGER := 7680;
        AddressWidth : INTEGER := 13);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of VN_pun_cn is
    component VN_pun_cn_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    VN_pun_cn_rom_U :  component VN_pun_cn_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


