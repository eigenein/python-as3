package game.util
{
   import com.progrestar.common.error.ClientErrorManager;
   import com.progrestar.common.lang.LocaleEnum;
   import engine.context.GameContext;
   
   public class FoulLanguageFilter
   {
      
      private static const notLetterNumericPattern:RegExp = /[^a-zA-Zа-яА-Яё0-9\s]/g;
      
      private static const spaceSymbol:String = " ";
      
      private static var goodWords:Array = ["дезмонда","застрахуйте","одномандатный","подстрахуй","психуй"];
      
      private static var goodPatterns:Array = [".*л(о|а)х(о|а)трон.*",".*к(о|а)манд.*",".*истр(е|и)блять.*",".*психу.*",".*м(а|о)нд(а|о)рин.*",".*@.*\\.(ру|сом|нет)$",".*(о|а)ск(о|а)рблять.*",".*п(о|а)тр(е|и)блять.*","хул(е|и)ган",".*р(а|о)ссл(а|о)блять.*","^уху",".*her.*"];
      
      private static var badPatternsRU:Array = ["^к(о|а)зел$","^к(а|о)злина$","^лошар.*","^сучк(а|у|и|е|ой|ай).*","^л(о)+х[уеыаоэяию].*",".*х(у)+(й|и|я|е|л(и|е))+.*","^залуп.*","^сволоч(ь|ъ|и|уга|ам|ами).*",".*урод(ы|у|ам|ина|ины).*",".*бл(я)+(т|д).*",".*гандо.*","^м(а|о)нд(а|о).*",".*(д(о|а)лб(о|а)|разъ|разь|за|вы|по)ебы*.*",".*сперма.*","^(о|а)н(о|а)нист.*","^придур(ок|ки).*","^еб.*","^уеб.*","^иба.*","(с|сц)ук(а|о|и|у).*","^д(е|и)би(л|лы).*","^бл(я|т|д).*",".*шалав(а|ы|ам|е|ами).*",".*х(е)+р.*","^муд(е|ил|о|а|я|еб).*",".*[уеыаоэяию]еб$","^сос(ать|и|ешь|у)$",".*п(и|е|ы)(з|с)д.*",".*пид(а|о|е)?р.*",".*шлюх(а|и|ам|е|ами).*",".*пр(а|о)ст(и|е)т(у|е)тк(а|и|ам|е|ами).*"];
      
      private static var badPatternsEN:Array = [".*f(u|a|o)+ck.*","^dick.*","^as*hole.*","^fagg?(o|i|e)t.*","^fai?g.*","^bas+t(a|e)rd.*","^ass.*",".*b(i)+a?tch.*",".*whore.*","^slut.*","^bullshit.*",".*cunt.*","^turd.*","^shitass.*","^cocksucker.*","^prick.*","^coc?k.*",".*penis.*","^sh(i|y)+e?t.*","^piss.*","^motherfucker.*","^tits.*","^titt?(y|ie)s?.*",".*suck.*","^retard.*","^nigg?(a|er).*","^anus.*","^blowjob.*","^boffing.*","^butt(hole|wipe).*","^cawk.*","^clit.*","^cum.*","^dildo.*","^jizz.*","^mast(u|e)?rbai?te.*","^slut.*","^va(g|j)ina.*","^blowjob.*"];
      
      private static var badPatterns:Array;
      
      private static var badPatternsExtended:Array;
      
      private static var latinSymbolsMap:Object = {
         "a":["@"],
         "c":["k"],
         "f":["ph"],
         "s":["$","z"],
         "o":["0"],
         "i":["\\|","!"]
      };
      
      private static var cyrillicSymbolsMap:Object = {
         "а":["а","a","@"],
         "б":["б","6","b"],
         "в":["в","b","v"],
         "г":["г","r","g"],
         "д":["д","d","g"],
         "е":["е","e","ё"],
         "ё":["ё","е","e"],
         "ж":["ж","zh"],
         "з":["з","3","z"],
         "и":["и","u","i"],
         "й":["й","u","y","i"],
         "к":["к","k"],
         "л":["л","l","ji"],
         "м":["м","m"],
         "н":["н","h","n"],
         "о":["о","o","0"],
         "п":["п","n","p"],
         "р":["р","r","p"],
         "с":["с","c","s"],
         "т":["т","m","t"],
         "у":["у","y","u"],
         "ф":["ф","f"],
         "х":["х","x","h","}{"],
         "ц":["ц","c","u,"],
         "ч":["ч","ch"],
         "ш":["ш","sh"],
         "щ":["щ","sch"],
         "ь":["ь","b"],
         "ы":["ы","bi"],
         "ъ":["ъ"],
         "э":["э","е","e"],
         "ю":["ю","io"],
         "я":["я","ya"]
      };
       
      
      public function FoulLanguageFilter()
      {
         super();
      }
      
      private static function initializeBadPatterns() : void
      {
         badPatterns = [];
         badPatterns = badPatterns.concat(badPatternsEN);
         if(GameContext.instance.localeID == LocaleEnum.RUSSIAN.id)
         {
            badPatterns = badPatterns.concat(badPatternsRU);
         }
      }
      
      private static function initializeBadPatternsExtended() : void
      {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = 0;
         var _loc6_:int = 0;
         if(!badPatterns)
         {
            initializeBadPatterns();
         }
         badPatternsExtended = [];
         _loc4_ = uint(0);
         while(_loc4_ < badPatterns.length)
         {
            _loc1_ = badPatterns[_loc4_];
            if(_loc1_)
            {
               _loc3_ = "";
               _loc6_ = 0;
               while(_loc6_ < _loc1_.length)
               {
                  _loc5_ = _loc1_.substr(_loc6_,1);
                  _loc7_ = latinSymbolsMap[_loc5_];
                  if(!_loc7_ && GameContext.instance.localeID == LocaleEnum.RUSSIAN.id)
                  {
                     _loc7_ = cyrillicSymbolsMap[_loc5_];
                  }
                  if(_loc7_ && _loc7_.length > 0)
                  {
                     _loc3_ = _loc3_ + ("(" + _loc7_.join("|") + ")");
                  }
                  else
                  {
                     _loc3_ = _loc3_ + _loc5_;
                  }
                  _loc6_++;
               }
               badPatternsExtended.push(_loc3_);
            }
            _loc4_++;
         }
      }
      
      public static function containBadWords(param1:String, param2:Boolean = true) : Boolean
      {
         return param1 != checkBadWordsAndCorrect(param1,param2);
      }
      
      public static function checkBadWordsAndCorrect(param1:String, param2:Boolean = true) : String
      {
         var _loc11_:* = 0;
         var _loc7_:Boolean = false;
         var _loc4_:* = null;
         var _loc10_:* = null;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc3_:* = param1;
         if(param1 && param1.length)
         {
            _loc11_ = uint(0);
            _loc7_ = true;
            while(_loc7_)
            {
               _loc7_ = false;
               _loc8_ = cleanBadSymbols(param1.toLowerCase());
               if(_loc8_)
               {
                  _loc4_ = _loc8_.split(" ");
                  _loc5_ = uint(0);
                  while(_loc5_ < _loc4_.length)
                  {
                     _loc10_ = _loc4_[_loc5_];
                     if(!isGoodWord(_loc10_))
                     {
                        _loc9_ = isInBadPatterns(_loc10_);
                        if(_loc9_ != null)
                        {
                           param1 = replaceBadWord(param1,_loc9_);
                           _loc7_ = true;
                           _loc11_++;
                        }
                     }
                     _loc5_++;
                  }
                  _loc9_ = containsBadWordInSpaceWords(_loc4_);
                  if(_loc9_ != null && !isGoodWord(_loc9_))
                  {
                     param1 = replaceBadWord(param1,_loc9_);
                     _loc7_ = true;
                     _loc11_++;
                  }
               }
               if(param2 && !_loc7_)
               {
                  _loc4_ = param1.toLocaleLowerCase().split(" ");
                  _loc6_ = uint(0);
                  while(_loc6_ < _loc4_.length)
                  {
                     _loc10_ = _loc4_[_loc6_];
                     if(!isGoodWord(_loc10_))
                     {
                        _loc9_ = isInBadPatternsExtended(_loc10_);
                        if(_loc9_ != null)
                        {
                           param1 = replaceBadWord(param1,_loc9_);
                           _loc7_ = true;
                           _loc11_++;
                        }
                     }
                     _loc6_++;
                  }
                  _loc9_ = containsBadWordInSpaceWords(_loc4_);
                  if(_loc9_ != null && !isGoodWord(_loc9_))
                  {
                     param1 = replaceBadWord(param1,_loc9_);
                     _loc7_ = true;
                     _loc11_++;
                  }
               }
               if(_loc11_ >= 100)
               {
                  ClientErrorManager.action_handleError(new Error("FoulLanguageFilterError: Replace word error"),"Text: " + _loc3_);
                  return param1;
               }
            }
         }
         return param1;
      }
      
      public static function isGoodWord(param1:String) : Boolean
      {
         return isInGoodWords(param1) || isInGoodPatterns(param1);
      }
      
      private static function replaceBadWord(param1:String, param2:String) : String
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1 && param1.length && param2 && param2.length)
         {
            _loc3_ = [];
            _loc7_ = 0;
            while(_loc7_ < param1.length)
            {
               _loc4_ = param1.charAt(_loc7_).toLowerCase();
               if(_loc4_ == param2.charAt(_loc3_.length))
               {
                  _loc3_.push(_loc7_);
               }
               else if(_loc3_.length > 0 && _loc4_ != " " && !notLetterNumericTest(_loc4_))
               {
                  _loc3_.length = 0;
                  if(_loc4_ == param2.charAt(_loc3_.length))
                  {
                     _loc3_.push(_loc7_);
                  }
               }
               if(_loc3_.length == param2.length)
               {
                  _loc5_ = _loc3_[0];
                  _loc6_ = _loc3_[_loc3_.length - 1];
                  param1 = param1.replace(param1.substring(_loc5_,_loc6_ + 1),"***");
                  break;
               }
               _loc7_++;
            }
         }
         return param1;
      }
      
      private static function notLetterNumericTest(param1:String) : Boolean
      {
         notLetterNumericPattern.lastIndex = 0;
         return notLetterNumericPattern.test(param1);
      }
      
      private static function cleanBadSymbols(param1:String) : String
      {
         notLetterNumericPattern.lastIndex = 0;
         return param1.replace(notLetterNumericPattern,"");
      }
      
      private static function isInGoodWords(param1:String) : Boolean
      {
         var _loc2_:* = 0;
         _loc2_ = uint(0);
         while(_loc2_ < goodWords.length)
         {
            if(param1 == goodWords[_loc2_])
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private static function isInGoodPatterns(param1:String) : Boolean
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         _loc3_ = uint(0);
         while(_loc3_ < goodPatterns.length)
         {
            _loc2_ = new RegExp(goodPatterns[_loc3_]);
            if(_loc2_.test(param1))
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private static function isInBadPatterns(param1:String) : String
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         if(!badPatterns)
         {
            initializeBadPatterns();
         }
         _loc3_ = uint(0);
         while(_loc3_ < badPatterns.length)
         {
            _loc2_ = new RegExp(badPatterns[_loc3_]);
            if(_loc2_.test(param1))
            {
               return param1;
            }
            _loc3_++;
         }
         return null;
      }
      
      private static function isInBadPatternsExtended(param1:String) : String
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         if(!badPatternsExtended)
         {
            initializeBadPatternsExtended();
         }
         _loc3_ = uint(0);
         while(_loc3_ < badPatternsExtended.length)
         {
            _loc2_ = new RegExp(badPatternsExtended[_loc3_]);
            if(_loc2_.test(param1))
            {
               return param1;
            }
            _loc3_++;
         }
         return null;
      }
      
      private static function containsBadWordInSpaceWords(param1:Array) : String
      {
         var _loc3_:* = 0;
         var _loc4_:* = null;
         var _loc2_:Array = findSpaceWords(param1);
         _loc3_ = uint(0);
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = isInBadPatterns(_loc2_[_loc3_]);
            if(_loc4_ != null)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private static function findSpaceWords(param1:Array) : Array
      {
         var _loc4_:* = 0;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc6_:Array = [];
         _loc4_ = uint(0);
         while(_loc4_ < param1.length)
         {
            _loc2_ = param1[_loc4_];
            _loc5_ = _loc4_ + 1;
            while(_loc5_ < param1.length)
            {
               _loc3_ = param1[_loc5_];
               if(_loc3_.length <= 3)
               {
                  _loc2_ = _loc2_ + _loc3_;
                  _loc6_.push(_loc2_);
                  _loc5_++;
                  continue;
               }
               break;
            }
            _loc4_++;
         }
         return _loc6_;
      }
   }
}
