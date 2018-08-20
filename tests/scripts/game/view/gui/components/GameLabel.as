package game.view.gui.components
{
   import feathers.controls.Label;
   import feathers.controls.TextInput;
   import feathers.controls.text.BitmapFontTextRenderer;
   import feathers.controls.text.TextFieldTextRenderer;
   import feathers.core.ITextRenderer;
   import feathers.text.BitmapFontTextFormat;
   import flash.text.TextFormat;
   import game.assets.storage.AssetStorage;
   import game.view.theme.HeroesThemeBase;
   import ru.crazybit.socexp.view.core.text.renderer.ShadowedSpecialTextRenderer;
   
   public class GameLabel extends Label
   {
       
      
      protected var _useBmTextRendererAnyway:Boolean = false;
      
      protected var _gameTextRendererFactory:Function = null;
      
      protected var _useTextFieldTextRenderer:Boolean = false;
      
      public function GameLabel(param1:Boolean = false)
      {
         super();
         _useBmTextRendererAnyway = param1;
      }
      
      public static function label(param1:String = null, param2:String = null, param3:Boolean = false) : GameLabel
      {
         var _loc4_:GameLabel = new ClipLabel(param3);
         if(!param1)
         {
            _loc4_.styleNameList.add("STYLE_DEFAULT_FONT");
         }
         else
         {
            _loc4_.styleNameList.add(param1);
         }
         if(param2)
         {
            _loc4_.text = param2;
         }
         return _loc4_;
      }
      
      public static function size16(param1:String = null) : GameLabel
      {
         var _loc2_:GameLabel = new ClipLabel();
         _loc2_.styleNameList.add("STYLE_DEFAULT_FONT_16");
         if(param1)
         {
            _loc2_.text = param1;
         }
         return _loc2_;
      }
      
      public static function size20(param1:String = null) : GameLabel
      {
         var _loc2_:GameLabel = new ClipLabel();
         _loc2_.styleNameList.add("STYLE_DEFAULT_FONT");
         if(param1)
         {
            _loc2_.text = param1;
         }
         return _loc2_;
      }
      
      public static function size24(param1:String = null) : GameLabel
      {
         var _loc2_:GameLabel = new ClipLabel();
         _loc2_.styleNameList.add("STYLE_DEFAULT_FONT_24");
         if(param1)
         {
            _loc2_.text = param1;
         }
         return _loc2_;
      }
      
      public static function size26(param1:String = null) : GameLabel
      {
         var _loc2_:GameLabel = new ClipLabel();
         _loc2_.textRendererProperties.textFormat = new BitmapFontTextFormat(AssetStorage.font.Officina26);
         if(param1)
         {
            _loc2_.text = param1;
         }
         return _loc2_;
      }
      
      public static function multiline20() : Label
      {
         var _loc1_:GameLabel = new ClipLabel();
         _loc1_.textRendererProperties.textFormat = new BitmapFontTextFormat(AssetStorage.font.Officina20_multiline,20);
         return _loc1_;
      }
      
      public static function input(param1:Number, param2:Number, param3:Boolean = false, param4:String = "", param5:String = null) : TextInput
      {
         var _loc6_:TextInput = new TextInput();
         _loc6_.nameList.add(!!param5?param5:"STYLE_INPUT_GAME");
         _loc6_.width = param1;
         _loc6_.height = param2;
         if(param3)
         {
            _loc6_.setFocus();
         }
         _loc6_.text = param4;
         return _loc6_;
      }
      
      public static function special14() : GameLabel
      {
         var _loc1_:GameLabel = new SpecialClipLabel();
         _loc1_.textRendererFactory = specialTextRendererFactory;
         _loc1_.styleNameList.add("STYLE_DEFAULT_FONT_14");
         return _loc1_;
      }
      
      public static function special16() : GameLabel
      {
         var _loc1_:GameLabel = new SpecialClipLabel();
         _loc1_.textRendererFactory = specialTextRendererFactory;
         _loc1_.styleNameList.add("STYLE_DEFAULT_FONT_16");
         return _loc1_;
      }
      
      public static function special24() : GameLabel
      {
         var _loc1_:GameLabel = new SpecialClipLabel();
         _loc1_.textRendererFactory = specialTextRendererFactory;
         _loc1_.wordWrap = true;
         _loc1_.styleNameList.add("STYLE_LABEL_DIALOG_HEADER");
         return _loc1_;
      }
      
      private static function specialTextRendererFactory() : ShadowedSpecialTextRenderer
      {
         var _loc1_:ShadowedSpecialTextRenderer = new ShadowedSpecialTextRenderer();
         _loc1_.shadowColor = 0;
         return _loc1_;
      }
      
      public static function nativeTextRendererFactory() : ITextRenderer
      {
         return new TextFieldTextRenderer();
      }
      
      public function get useBmTextRendererAnyway() : Boolean
      {
         return _useBmTextRendererAnyway;
      }
      
      public function get useTextFieldTextRenderer() : Boolean
      {
         return _useTextFieldTextRenderer;
      }
      
      override protected function draw() : void
      {
         var _loc2_:* = false;
         var _loc1_:* = false;
         var _loc3_:Boolean = this.isInvalid("data");
         if(_loc3_ && !_useBmTextRendererAnyway)
         {
            _loc2_ = Boolean(HeroesThemeBase.explicitUseNativeFont);
            if(!_loc2_ && _text)
            {
               _loc1_ = _text.search(AssetStorage.font.availableSymbols) != -1;
               if(!_loc2_)
               {
                  _loc2_ = _loc1_;
               }
            }
            changeRendererFactory(_loc2_);
            if(_loc2_ && _text)
            {
               prepareNativeText();
            }
         }
         super.draw();
      }
      
      protected function prepareNativeText() : void
      {
      }
      
      protected function changeRendererFactory(param1:Boolean) : Boolean
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:Boolean = false;
         _useTextFieldTextRenderer = param1;
         if(param1)
         {
            if(textRendererProperties.textFormat is BitmapFontTextFormat)
            {
               setNativeTextRenderer();
               _loc2_ = true;
            }
         }
         else if(textRendererProperties.textFormat is TextFormat)
         {
            setBitmapFontTextRenderer();
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      protected function setupTextRendererFactory(param1:Function) : void
      {
         if(_isValidating)
         {
            _textRendererFactory = param1;
            setInvalidationFlag("textRenderer");
         }
         else
         {
            textRendererFactory = param1;
         }
      }
      
      protected function setNativeTextRenderer() : void
      {
         var _loc2_:Object = textRendererProperties.textFormat;
         var _loc3_:TextFormat = new TextFormat(HeroesThemeBase.NATIVE_FONT_NAME,_loc2_.size,_loc2_.color);
         _loc3_.align = _loc2_.align;
         _loc3_.bold = true;
         textRendererProperties.textFormat = _loc3_;
         var _loc1_:Object = textRendererProperties;
         delete _loc1_.useSeparateBatch;
         setupTextRendererFactory(_nativeTextRendererFactory);
      }
      
      protected function setBitmapFontTextRenderer() : void
      {
         var _loc1_:Object = textRendererProperties.textFormat;
         textRendererProperties.textFormat = new BitmapFontTextFormat(AssetStorage.font.getBitmapFont(_loc1_.size as int),_loc1_.size as Number,_loc1_.color as uint,_loc1_.align);
         textRendererProperties.useSeparateBatch = false;
         setupTextRendererFactory(bitmapFontTextRendererFactory);
      }
      
      protected function bitmapFontTextRendererFactory() : ITextRenderer
      {
         return new BitmapFontTextRenderer();
      }
      
      protected function _nativeTextRendererFactory() : ITextRenderer
      {
         return new TextFieldTextRenderer();
      }
   }
}
