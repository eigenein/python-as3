package game.view.theme
{
   import engine.context.GameContext;
   import feathers.controls.Label;
   import feathers.controls.TextInput;
   import feathers.controls.text.StageTextTextEditor;
   import feathers.text.BitmapFontTextFormat;
   import feathers.themes.StyleNameFunctionTheme;
   import flash.text.Font;
   import flash.text.TextFormat;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.FontAssetStorage;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameLabel;
   import ru.crazybit.socexp.view.core.text.SpecialBitmapFontTextFormat;
   import starling.display.DisplayObjectContainer;
   import starling.filters.BlurFilter;
   
   public class HeroesThemeBase extends StyleNameFunctionTheme
   {
      
      public static const STYLE_BUTTON_LABELED:String = "STYLE_BUTTON_LABELED";
      
      public static const STYLE_BUTTON_LABELED_MULTILINE:String = "STYLE_BUTTON_LABELED_MULTILINE";
      
      public static const STYLE_TOGGLE_BUTTON_LABELED:String = "STYLE_TOGGLE_BUTTON_LABELED";
      
      public static const STYLE_DEFAULT_FONT:String = "STYLE_DEFAULT_FONT";
      
      public static const STYLE_DEFAULT_FONT_24:String = "STYLE_DEFAULT_FONT_24";
      
      public static const STYLE_DEFAULT_FONT_16:String = "STYLE_DEFAULT_FONT_16";
      
      public static const STYLE_DEFAULT_FONT_14:String = "STYLE_DEFAULT_FONT_14";
      
      public static const STYLE_INPUT_GAME:String = "STYLE_INPUT_GAME";
      
      public static const STYLE_LABEL_DIALOG_HEADER:String = "STYLE_LABEL_DIALOG_HEADER";
      
      public static const STYLE_LABEL_BRIGHT_GREEN:String = "STYLE_LABEL_BRIGHT_GREEN";
      
      public static const STYLE_LABEL_LIGHT_BROWN:String = "STYLE_LABEL_LIGHT_BROWN";
      
      public static const FONT_COLOR_LIGHT_BROWN:int = 15581850;
      
      public static const FONT_COLOR_BRIGHT_GREEN:int = 2543872;
      
      public static var NATIVE_FONT_NAME:String = "_sans";
      
      public static var NATIVE_FONT_SIZE_OFFSET:int = 0;
       
      
      protected var tfTf14:TextFormat;
      
      protected var tfTf16:TextFormat;
      
      protected var tfTf20:TextFormat;
      
      protected var tfTf24:TextFormat;
      
      protected var tfTf24_dialogHeader:TextFormat;
      
      protected var tfTf20_lightBrown:TextFormat;
      
      protected var tfTf26_brightGreen:TextFormat;
      
      protected var bmtf14:BitmapFontTextFormat;
      
      protected var bmtf16:BitmapFontTextFormat;
      
      protected var bmtf20:BitmapFontTextFormat;
      
      protected var bmtf24:BitmapFontTextFormat;
      
      protected var bmtf24_dialogHeader:BitmapFontTextFormat;
      
      protected var bmtf20_lightBrown:BitmapFontTextFormat;
      
      protected var bmtf26_brightGreen:BitmapFontTextFormat;
      
      private const NATIVE_FONT_COLOR:uint = 16777215;
      
      private const NATIVE_FONT_ALIGN:String = "left";
      
      public function HeroesThemeBase(param1:DisplayObjectContainer)
      {
         super();
         if(NATIVE_FONT_NAME == "_sans")
         {
            NATIVE_FONT_SIZE_OFFSET = -1;
         }
         setInitializers();
      }
      
      public static function get explicitUseNativeFont() : Boolean
      {
         return GameContext.instance.locale.isAsian;
      }
      
      protected function getAvailableFontName(param1:Array) : String
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = Font.enumerateFonts(true);
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(param1[_loc2_] == (_loc3_[_loc4_] as Font).fontName)
               {
                  return param1[_loc2_];
               }
               _loc4_++;
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function setInitializers() : void
      {
         var _loc1_:FontAssetStorage = AssetStorage.font;
         bmtf14 = new SpecialBitmapFontTextFormat(_loc1_.Officina14,14);
         bmtf16 = new SpecialBitmapFontTextFormat(_loc1_.Officina16,16);
         bmtf20 = new BitmapFontTextFormat(_loc1_.Officina20,20);
         bmtf24 = new BitmapFontTextFormat(_loc1_.Officina24,24);
         bmtf24_dialogHeader = new SpecialBitmapFontTextFormat(AssetStorage.font.Officina24,24,16764804,"center");
         bmtf26_brightGreen = new BitmapFontTextFormat(_loc1_.Officina26,26,2543872);
         bmtf20_lightBrown = new BitmapFontTextFormat(_loc1_.Officina20,20,15581850);
         tfTf14 = new TextFormat(NATIVE_FONT_NAME,14,16777215,null,null,null,null,null,null,null,null,null,-2);
         tfTf14.align = "left";
         tfTf16 = new TextFormat(NATIVE_FONT_NAME,16,16777215,null,null,null,null,null,null,null,null,null,-2);
         tfTf16.align = "left";
         tfTf20 = new TextFormat(NATIVE_FONT_NAME,20,16777215,null,null,null,null,null,null,null,null,null,-2);
         tfTf20.align = "left";
         tfTf24 = new TextFormat(NATIVE_FONT_NAME,24,16777215,null,null,null,null,null,null,null,null,null,-2);
         tfTf24.align = "left";
         tfTf24_dialogHeader = new TextFormat(NATIVE_FONT_NAME,24,16764804,null,null,null,null,null,null,null,null,null,-2);
         tfTf24_dialogHeader.align = "center";
         tfTf26_brightGreen = new TextFormat(NATIVE_FONT_NAME,26,2543872,null,null,null,null,null,null,null,null,null,-2);
         tfTf26_brightGreen.align = "left";
         tfTf20_lightBrown = new TextFormat(NATIVE_FONT_NAME,20,15581850,null,null,null,null,null,null,null,null,null,-2);
         tfTf20_lightBrown.align = "left";
         getStyleProviderForClass(TextInput).setFunctionForStyleName("STYLE_INPUT_GAME",textInputStyle);
         getStyleProviderForClass(Label).setFunctionForStyleName("STYLE_LABEL_DIALOG_HEADER",labelHeaderStyle);
         getStyleProviderForClass(Label).setFunctionForStyleName("STYLE_LABEL_BRIGHT_GREEN",labelColorBrightGreen);
         getStyleProviderForClass(Label).setFunctionForStyleName("STYLE_LABEL_LIGHT_BROWN",labelColorLightBrown);
         getStyleProviderForClass(Label).setFunctionForStyleName("STYLE_DEFAULT_FONT",labelDefaultFont);
         getStyleProviderForClass(Label).setFunctionForStyleName("STYLE_DEFAULT_FONT_24",labelDefaultFont24);
         getStyleProviderForClass(Label).setFunctionForStyleName("STYLE_DEFAULT_FONT_16",labelDefaultFont16);
         getStyleProviderForClass(Label).setFunctionForStyleName("STYLE_DEFAULT_FONT_14",labelDefaultFont14);
      }
      
      protected function textInputStyle(param1:TextInput) : void
      {
         param1.textEditorFactory = textInputStyle_textEditorFactory;
      }
      
      protected function textInputStyle_textEditorFactory() : StageTextTextEditor
      {
         var _loc1_:StageTextTextEditor = new StageTextTextEditor();
         _loc1_.fontFamily = "Arial";
         _loc1_.fontSize = 24;
         _loc1_.color = 16777215;
         return _loc1_;
      }
      
      private function applyStyle(param1:Label, param2:BitmapFontTextFormat, param3:TextFormat, param4:Boolean = false) : void
      {
         var _loc5_:Boolean = param1 is GameLabel && (param1 as GameLabel).useBmTextRendererAnyway;
         if(param1 is ClipLabel)
         {
            (param1 as ClipLabel).initTextRendererFactory();
         }
         if(HeroesThemeBase.explicitUseNativeFont && !_loc5_)
         {
            param1.textRendererProperties.textFormat = param3;
         }
         else
         {
            param1.textRendererProperties.textFormat = param2;
         }
         if(param4)
         {
            param1.filter = BlurFilter.createDropShadow(2,3.14159265358979 / 2,0,0.3,0,1);
         }
      }
      
      protected function labelDefaultFont14(param1:Label) : void
      {
         applyStyle(param1,bmtf14,tfTf14,true);
      }
      
      protected function labelDefaultFont16(param1:Label) : void
      {
         applyStyle(param1,bmtf16,tfTf16,true);
      }
      
      protected function labelDefaultFont24(param1:Label) : void
      {
         applyStyle(param1,bmtf24,tfTf24,true);
      }
      
      protected function labelDefaultFont(param1:Label) : void
      {
         applyStyle(param1,bmtf20,tfTf20,true);
      }
      
      protected function labelHeaderStyle(param1:Label) : void
      {
         applyStyle(param1,bmtf24_dialogHeader,tfTf24_dialogHeader,false);
      }
      
      protected function labelColorBrightGreen(param1:Label) : void
      {
         applyStyle(param1,bmtf26_brightGreen,tfTf26_brightGreen,true);
      }
      
      private function labelColorLightBrown(param1:Label) : void
      {
         applyStyle(param1,bmtf20_lightBrown,tfTf20_lightBrown,true);
      }
   }
}
