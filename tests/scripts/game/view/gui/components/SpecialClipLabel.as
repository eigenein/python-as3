package game.view.gui.components
{
   import com.progrestar.framework.ares.extension.textfield.ClipTextField;
   import feathers.controls.text.TextFieldTextRenderer;
   import feathers.core.ITextRenderer;
   import game.assets.storage.AssetStorage;
   import game.view.popup.theme.LabelStyle;
   import game.view.theme.HeroesThemeBase;
   import ru.crazybit.socexp.view.core.text.ColorChar;
   import ru.crazybit.socexp.view.core.text.NoColorChar;
   import ru.crazybit.socexp.view.core.text.SpecialBitmapFontTextFormat;
   import ru.crazybit.socexp.view.core.text.SpecialCharData;
   import ru.crazybit.socexp.view.core.text.SpriteChar;
   import ru.crazybit.socexp.view.core.text.TextureChar;
   import ru.crazybit.socexp.view.core.text.renderer.ShadowedSpecialTextRenderer;
   import ru.crazybit.socexp.view.core.text.renderer.SpecialTextRenderer;
   
   public class SpecialClipLabel extends ClipLabel
   {
       
      
      private var htmlText:String;
      
      private var noShadow:Boolean;
      
      public function SpecialClipLabel(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false)
      {
         this.noShadow = param3;
         super(param1,param2);
      }
      
      override public function initTextRendererFactory() : void
      {
         _useTextFieldTextRenderer = !_useBmTextRendererAnyway && HeroesThemeBase.explicitUseNativeFont;
         if(_useTextFieldTextRenderer)
         {
            textRendererFactory = _nativeTextRendererFactory;
         }
         else
         {
            textRendererProperties.useSeparateBatch = false;
            textRendererFactory = bitmapFontTextRendererFactory;
         }
      }
      
      override protected function initTextFormat(param1:ClipTextField) : void
      {
         if(_useTextFieldTextRenderer)
         {
            textRendererProperties.textFormat = LabelStyle.getNativeTextFormat(param1);
         }
         else
         {
            textRendererProperties.textFormat = LabelStyle.fromSpecialClipTextField(param1);
         }
      }
      
      override protected function prepareNativeText() : void
      {
         var _loc6_:int = 0;
         var _loc9_:* = null;
         var _loc2_:* = null;
         var _loc10_:* = null;
         var _loc1_:Boolean = false;
         var _loc3_:Array = this._text.split("^");
         var _loc7_:String = "";
         var _loc5_:int = _loc3_.length;
         var _loc8_:Boolean = true;
         var _loc4_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = _loc3_[_loc6_];
            if(SpecialCharData.isSpecialFormat(_loc9_))
            {
               _loc1_ = true;
               _loc2_ = ColorChar.tryNewColorChar(_loc9_) as ColorChar;
               if(_loc2_)
               {
                  if(!_loc8_)
                  {
                     _loc7_ = _loc7_ + "</font>";
                  }
                  if(_loc2_ is NoColorChar)
                  {
                     _loc4_.pop();
                  }
                  else
                  {
                     _loc4_.push(_loc2_.color.toString(16));
                     _loc8_ = false;
                  }
                  if(_loc4_.length > 0)
                  {
                     _loc7_ = _loc7_ + ("<font color=\"#" + _loc4_[_loc4_.length - 1] + "\">");
                  }
               }
               else
               {
                  _loc10_ = TextureChar.tryNewTextureChar(_loc9_) as SpriteChar;
                  if(_loc10_)
                  {
                     var _loc11_:* = _loc10_.spriteName;
                     if("gold_vip" !== _loc11_)
                     {
                        if("vip_6" !== _loc11_)
                        {
                           if("url_icon" !== _loc11_)
                           {
                              if("billing_vip_green_bullet" !== _loc11_)
                              {
                                 if("alchemy_arrow_right" !== _loc11_)
                                 {
                                    if("iconvsmall" !== _loc11_)
                                    {
                                       _loc7_ = _loc7_ + _loc10_.spriteName;
                                    }
                                    else
                                    {
                                       _loc7_ = _loc7_ + "<font size=\"28\" color=\"#86E94E\">✓</font>";
                                    }
                                 }
                                 else
                                 {
                                    _loc7_ = _loc7_ + "<font color=\"#E8B47B\">>></font>";
                                 }
                              }
                              else
                              {
                                 _loc7_ = _loc7_ + "<font size=\"20\" color=\"#86E94E\">•</font>";
                              }
                           }
                           else
                           {
                              _loc7_ = _loc7_ + "<font size=\"24\" color=\"#86E94E\">→</font>";
                           }
                        }
                        else
                        {
                           _loc7_ = _loc7_ + "<font size=\"20\" color=\"#F2E84A\">VIP6</font>";
                        }
                     }
                     else
                     {
                        _loc7_ = _loc7_ + "<font size=\"20\" color=\"#F2E84A\">VIP</font>";
                     }
                  }
               }
            }
            else
            {
               _loc7_ = _loc7_ + _loc9_;
            }
            _loc6_++;
         }
         if(_loc4_.length > 0)
         {
            _loc7_ = _loc7_ + "</font>";
         }
         htmlText = !!_loc1_?_loc7_:null;
      }
      
      override protected function refreshTextRendererData() : void
      {
         var _loc2_:* = null;
         var _loc1_:String = this._text;
         if(textRenderer is TextFieldTextRenderer)
         {
            _loc2_ = textRenderer as TextFieldTextRenderer;
            if(htmlText != null)
            {
               _loc2_.isHTML = true;
               _loc1_ = htmlText;
            }
            else
            {
               _loc2_.isHTML = false;
            }
         }
         this.textRenderer.text = _loc1_;
         this.textRenderer.visible = this._text && this._text.length > 0;
      }
      
      private function createImageReplacementText(param1:int, param2:uint, param3:String) : String
      {
         return "<font size=\"" + param1 + "\" color=\"#" + param2.toString(16) + "\">" + param3 + "</font>";
      }
      
      override protected function setBitmapFontTextRenderer() : void
      {
         var _loc1_:Object = textRendererProperties.textFormat;
         textRendererProperties.textFormat = new SpecialBitmapFontTextFormat(AssetStorage.font.getBitmapFont(_loc1_.size as int),_loc1_.size as Number,_loc1_.color as uint,_loc1_.align);
         textRendererProperties.useSeparateBatch = false;
         setupTextRendererFactory(bitmapFontTextRendererFactory);
         if(filter != null)
         {
            filter.dispose();
            filter = null;
         }
      }
      
      override protected function setNativeTextRenderer() : void
      {
         super.setNativeTextRenderer();
         if(filter == null)
         {
            createFilter();
         }
      }
      
      override protected function bitmapFontTextRendererFactory() : ITextRenderer
      {
         var _loc1_:* = null;
         if(noShadow)
         {
            return new SpecialTextRenderer();
         }
         _loc1_ = new ShadowedSpecialTextRenderer();
         _loc1_.shadowColor = 0;
         return _loc1_;
      }
      
      override protected function _nativeTextRendererFactory() : ITextRenderer
      {
         var _loc1_:TextFieldTextRenderer = new TextFieldTextRenderer();
         _loc1_.isHTML = htmlText != null;
         return _loc1_;
      }
   }
}
