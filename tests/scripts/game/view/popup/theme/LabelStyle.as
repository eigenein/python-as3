package game.view.popup.theme
{
   import com.progrestar.framework.ares.extension.textfield.ClipTextField;
   import com.progrestar.framework.ares.extension.textfield.TextFieldEncoder;
   import feathers.controls.text.TextFieldTextRenderer;
   import feathers.core.ITextRenderer;
   import feathers.text.BitmapFontTextFormat;
   import flash.text.TextFormat;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameLabel;
   import game.view.theme.HeroesThemeBase;
   import ru.crazybit.socexp.view.core.text.SpecialBitmapFontTextFormat;
   import starling.filters.BlurFilter;
   import starling.filters.FragmentFilter;
   import starling.text.BitmapFont;
   
   public class LabelStyle
   {
       
      
      public function LabelStyle()
      {
         super();
      }
      
      public static function createLabel(param1:int, param2:uint, param3:String, param4:Boolean = false) : GameLabel
      {
         size = param1;
         color = param2;
         align = param3;
         wordWrap = param4;
         var label:GameLabel = new ClipLabel();
         if(HeroesThemeBase.explicitUseNativeFont)
         {
            label.textRendererFactory = function():ITextRenderer
            {
               return new TextFieldTextRenderer();
            };
            var format:TextFormat = new TextFormat(HeroesThemeBase.NATIVE_FONT_NAME,size,color);
            format.align = align;
            format.bold = true;
            label.textRendererProperties.textFormat = format;
         }
         else
         {
            label.textRendererProperties.textFormat = new BitmapFontTextFormat(AssetStorage.font.getBitmapFont(size),size,color,align);
            label.filter = createDropShadowFilter();
         }
         label.wordWrap = wordWrap;
         return label;
      }
      
      public static function buttonLabel_size30() : GameLabel
      {
         return createLabel(26,15007564,"center");
      }
      
      public static function buttonLabel_size26_blue() : GameLabel
      {
         return createLabel(26,9826047,"center");
      }
      
      public static function label_size26_white_center() : GameLabel
      {
         return createLabel(26,16383999,"center");
      }
      
      public static function textFormat_buttonLabel_size18_left() : BitmapFontTextFormat
      {
         return new BitmapFontTextFormat(AssetStorage.font.Officina18,18,15007564,"left");
      }
      
      public static function textFormat_buttonLabel_size18_center() : BitmapFontTextFormat
      {
         return new BitmapFontTextFormat(AssetStorage.font.Officina18,18,15007564,"center");
      }
      
      public static function fromClipTextFieldNative(param1:ClipTextField) : TextFormat
      {
         return new TextFormat("Roboto Condensed",param1.fontHeight,param1.textColor,true);
      }
      
      public static function fromClipTextField(param1:ClipTextField) : BitmapFontTextFormat
      {
         var _loc3_:* = null;
         var _loc2_:String = TextFieldEncoder.tfAlignCodeToAlign(param1.align);
         var _loc4_:* = param1.fontHeight;
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
                              _loc3_ = !!param1.multiline?AssetStorage.font.Officina16_multiline:AssetStorage.font.Officina16;
                           }
                           else
                           {
                              _loc3_ = AssetStorage.font.Officina52;
                           }
                        }
                        else
                        {
                           _loc3_ = AssetStorage.font.Officina26;
                        }
                     }
                     else
                     {
                        _loc3_ = AssetStorage.font.Officina24;
                     }
                  }
                  else
                  {
                     _loc3_ = !!param1.multiline?AssetStorage.font.Officina20_multiline:AssetStorage.font.Officina20;
                  }
               }
               else
               {
                  _loc3_ = !!param1.multiline?AssetStorage.font.Officina18_multiline:AssetStorage.font.Officina18;
               }
            }
            else
            {
               _loc3_ = !!param1.multiline?AssetStorage.font.Officina16_multiline:AssetStorage.font.Officina16;
            }
         }
         else
         {
            _loc3_ = AssetStorage.font.Officina14_multiline;
         }
         return new BitmapFontTextFormat(_loc3_,param1.fontHeight,param1.textColor,_loc2_);
      }
      
      public static function fromSpecialClipTextField(param1:ClipTextField) : SpecialBitmapFontTextFormat
      {
         var _loc3_:* = null;
         var _loc2_:String = TextFieldEncoder.tfAlignCodeToAlign(param1.align);
         var _loc4_:* = param1.fontHeight;
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
                              _loc3_ = !!param1.multiline?AssetStorage.font.Officina16_multiline:AssetStorage.font.Officina16;
                           }
                           else
                           {
                              _loc3_ = AssetStorage.font.Officina52;
                           }
                        }
                        else
                        {
                           _loc3_ = AssetStorage.font.Officina26;
                        }
                     }
                     else
                     {
                        _loc3_ = AssetStorage.font.Officina24;
                     }
                  }
                  else
                  {
                     _loc3_ = !!param1.multiline?AssetStorage.font.Officina20_multiline:AssetStorage.font.Officina20;
                  }
               }
               else
               {
                  _loc3_ = !!param1.multiline?AssetStorage.font.Officina18_multiline:AssetStorage.font.Officina18;
               }
            }
            else
            {
               _loc3_ = !!param1.multiline?AssetStorage.font.Officina16_multiline:AssetStorage.font.Officina16;
            }
         }
         else
         {
            _loc3_ = AssetStorage.font.Officina14_multiline;
         }
         return new SpecialBitmapFontTextFormat(_loc3_,param1.fontHeight,param1.textColor,_loc2_);
      }
      
      public static function buttonLabel_size18_left() : GameLabel
      {
         return createLabel(18,15007564,"left");
      }
      
      public static function buttonLabel_size18() : GameLabel
      {
         return createLabel(18,15007564,"center");
      }
      
      public static function buttonLabel_size18_blue() : GameLabel
      {
         return createLabel(18,9958639,"center");
      }
      
      public static function label_size24_number() : GameLabel
      {
         return createLabel(24,16711404,"center");
      }
      
      public static function label_size24_header() : GameLabel
      {
         return createLabel(24,16764804,"center");
      }
      
      public static function label_size18_white() : GameLabel
      {
         return createLabel(18,16777215,"left");
      }
      
      public static function label_size20() : GameLabel
      {
         return createLabel(20,16764804,"left");
      }
      
      public static function label_size20_white_right() : GameLabel
      {
         return createLabel(20,16250868,"right");
      }
      
      public static function textFormat_size18() : BitmapFontTextFormat
      {
         return new BitmapFontTextFormat(AssetStorage.font.Officina18,18,16770485,"left");
      }
      
      public static function textFormat_size16() : BitmapFontTextFormat
      {
         return new BitmapFontTextFormat(AssetStorage.font.Officina16,16,16770485,"left");
      }
      
      public static function label_size18() : GameLabel
      {
         return createLabel(18,16770485,"left");
      }
      
      public static function label_size16_multiline() : GameLabel
      {
         return createLabel(16,16770485,"left",true);
      }
      
      public static function buttonLabel_size16_white() : GameLabel
      {
         return createLabel(16,16770485,"center",true);
      }
      
      public static function buttonLabel_size18_vip() : GameLabel
      {
         return createLabel(18,15984460,"center",true);
      }
      
      public static function buttonLabel_size18_skillUpgrade() : GameLabel
      {
         return createLabel(18,15984460,"center",true);
      }
      
      public static function label_size18_right() : GameLabel
      {
         return createLabel(18,16770485,"right");
      }
      
      public static function label_size18_center() : GameLabel
      {
         return createLabel(18,16770485,"center");
      }
      
      public static function label_size18_center_multiline() : GameLabel
      {
         return createLabel(18,16770485,"center",true);
      }
      
      public static function label_size24_beige() : GameLabel
      {
         return createLabel(24,16770485,"left");
      }
      
      public static function label_size24_beige_center() : GameLabel
      {
         return createLabel(24,16770485,"center");
      }
      
      public static function label_size24_white() : GameLabel
      {
         return createLabel(24,16777215,"left");
      }
      
      public static function getNativeTextFormat(param1:ClipTextField) : TextFormat
      {
         var _loc3_:String = TextFieldEncoder.tfAlignCodeToAlign(param1.align);
         var _loc2_:TextFormat = new TextFormat(HeroesThemeBase.NATIVE_FONT_NAME,param1.fontHeight + HeroesThemeBase.NATIVE_FONT_SIZE_OFFSET,param1.textColor);
         _loc2_.align = _loc3_;
         _loc2_.bold = true;
         return _loc2_;
      }
      
      public static function createDropShadowFilter() : FragmentFilter
      {
         return BlurFilter.createDropShadow(2,3.14159265358979 / 2,0,0.5,0,1);
      }
      
      public static function getStyleInitializer(param1:String) : Function
      {
         return LabelStyle[param1];
      }
   }
}
