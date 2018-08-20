package game.assets.storage
{
   import engine.core.assets.RequestableAsset;
   import game.assets.FontAsset;
   import starling.text.BitmapFont;
   
   public class FontAssetStorage extends AssetTypeStorage
   {
       
      
      public var Officina14:BitmapFont;
      
      public var Officina14_multiline:BitmapFont;
      
      public var Officina16:BitmapFont;
      
      public var Officina16_multiline:BitmapFont;
      
      public var Officina18:BitmapFont;
      
      public var Officina18_multiline:BitmapFont;
      
      public var Officina20:BitmapFont;
      
      public var Officina20_multiline:BitmapFont;
      
      public var Officina24:BitmapFont;
      
      public var Officina26:BitmapFont;
      
      public var Officina52:BitmapFont;
      
      public var monospace:BitmapFont;
      
      public var numbersMedium:BitmapFont;
      
      public var numbersLarge:BitmapFont;
      
      public var templateSize:int = 52;
      
      public var templateBaseline:Number = 50;
      
      public var availableSymbols:RegExp;
      
      public function FontAssetStorage()
      {
         super();
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
      }
      
      override public function complete(param1:*) : void
      {
         super.complete(param1);
         Officina14 = getFont("Officina14");
         Officina16 = getFont("Officina16");
         Officina18 = getFont("Officina18");
         Officina20 = getFont("Officina20");
         Officina24 = getFont("Officina24");
         Officina26 = getFont("Officina26");
         Officina52 = getFont("Officina52");
         templateBaseline = Officina52.baseline;
         monospace = getFont("monospace");
         numbersMedium = getFont("medium_numbers");
         numbersLarge = getFont("large_numbers");
         Officina14_multiline = getAsset("Officina14").fontCopy();
         Officina14_multiline.lineHeight = 13;
         Officina16_multiline = getAsset("Officina16").fontCopy();
         Officina16_multiline.lineHeight = 15;
         Officina18_multiline = getAsset("Officina18").fontCopy();
         Officina18_multiline.lineHeight = 17;
         Officina20_multiline = getAsset("Officina20").fontCopy();
         Officina20_multiline.lineHeight = 19;
         var _loc2_:String = getSymbols(Officina26);
         _loc2_ = _loc2_.replace("\\","\\\\");
         _loc2_ = _loc2_.replace("^","\\^");
         _loc2_ = _loc2_.replace("-","\\-");
         _loc2_ = _loc2_.replace("]","\\]");
         _loc2_ = _loc2_.replace("[","\\[");
         _loc2_ = _loc2_.replace(".","\\.");
         availableSymbols = new RegExp("[^\n\r" + _loc2_ + "]");
      }
      
      private function getSymbols(param1:BitmapFont) : String
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = param1.getCharIDs();
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = _loc2_ + String.fromCharCode(_loc4_[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getFont(param1:String) : BitmapFont
      {
         return getAsset(param1).font;
      }
      
      public function getBitmapFont(param1:int, param2:Boolean = false) : BitmapFont
      {
         var _loc3_:* = null;
         var _loc4_:* = param1;
         if(14 !== _loc4_)
         {
            if(16 !== _loc4_)
            {
               if(18 !== _loc4_)
               {
                  if(20 !== _loc4_)
                  {
                     if(24 !== _loc4_)
                     {
                        if(26 !== _loc4_)
                        {
                           if(52 !== _loc4_)
                           {
                              if(param1 <= 14)
                              {
                                 _loc3_ = AssetStorage.font.Officina14;
                              }
                              else if(param1 <= 26)
                              {
                                 _loc3_ = AssetStorage.font.Officina26;
                              }
                              else
                              {
                                 _loc3_ = AssetStorage.font.Officina52;
                              }
                           }
                           else
                           {
                              _loc3_ = Officina52;
                           }
                        }
                        else
                        {
                           _loc3_ = Officina26;
                        }
                     }
                     else
                     {
                        _loc3_ = Officina24;
                     }
                  }
                  else
                  {
                     _loc3_ = !!param2?Officina20_multiline:Officina20;
                  }
               }
               else
               {
                  _loc3_ = !!param2?Officina18_multiline:Officina18;
               }
            }
            else
            {
               _loc3_ = !!param2?Officina16_multiline:Officina16;
            }
         }
         else
         {
            _loc3_ = !!param2?Officina14_multiline:Officina14;
         }
         return _loc3_;
      }
      
      override protected function createEntry(param1:String, param2:*) : RequestableAsset
      {
         var _loc3_:* = FontAsset.create(param2);
         dict[param1] = _loc3_;
         return _loc3_;
      }
      
      public function getAsset(param1:String) : FontAsset
      {
         return dict[param1] as FontAsset;
      }
   }
}
