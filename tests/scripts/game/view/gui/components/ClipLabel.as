package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.extension.TextFieldDataExtension;
   import com.progrestar.framework.ares.extension.textfield.ClipTextField;
   import engine.core.clipgui.IGuiClip;
   import feathers.controls.text.BitmapFontTextRenderer;
   import feathers.core.ITextRenderer;
   import feathers.text.BitmapFontTextFormat;
   import flash.geom.Point;
   import flash.text.TextLineMetrics;
   import game.util.FontUtils;
   import game.view.popup.theme.LabelStyle;
   import game.view.theme.HeroesThemeBase;
   import ru.crazybit.socexp.view.core.text.renderer.SpecialTextRenderer;
   import starling.display.DisplayObject;
   
   public class ClipLabel extends GameLabel implements IGuiClip
   {
       
      
      private const helperPoint:Point = new Point();
      
      protected var autoSize:Boolean;
      
      protected var node:Node;
      
      protected var ctf:ClipTextField;
      
      public function ClipLabel(param1:Boolean = false, param2:Boolean = false)
      {
         super(param2);
         this.autoSize = param1;
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      public function get container() : DisplayObject
      {
         return this;
      }
      
      public function get assetHeight() : Number
      {
         return node.clip.bounds.height - 4;
      }
      
      public function get defaultTextColor() : uint
      {
         return ctf.textColor;
      }
      
      public function initTextRendererFactory() : void
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
         createFilter();
      }
      
      public function setNode(param1:Node) : void
      {
         var _loc4_:* = null;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         this.node = param1;
         var _loc5_:int = 0;
         var _loc2_:TextFieldDataExtension = TextFieldDataExtension.fromAsset(param1.clip.resource);
         ctf = !!_loc2_?_loc2_.getClipTextField(param1.clip):null;
         if(!_loc2_ || !ctf)
         {
            return;
            §§push(trace(this + "Для ассета с клипом " + param1.clip.className + " не определена TextFieldData"));
         }
         else
         {
            initTextRendererFactory();
            if(_useTextFieldTextRenderer)
            {
               _loc4_ = FontUtils.getNativeTextFieldMetrics(ctf.fontHeight);
               _loc3_ = FontUtils.getGameFontBaselineBySize(ctf.fontHeight);
               _loc5_ = Math.round(_loc3_ - _loc4_.ascent) - HeroesThemeBase.NATIVE_FONT_SIZE_OFFSET;
               if(!ctf.multiline)
               {
                  height = _loc4_.height;
               }
            }
            initTextFormat(ctf);
            wordWrap = ctf.multiline;
            if(!autoSize)
            {
               _loc6_ = ctf.align == 2?4:2;
               width = param1.clip.bounds.width - _loc6_;
               if(!ctf.multiline && !_useTextFieldTextRenderer)
               {
                  height = param1.clip.bounds.height - 2;
               }
            }
            transformationMatrix = param1.state.matrix;
            alpha = param1.state.colorMode == 1?param1.state.colorAlpha:1;
            x = x + (param1.clip.bounds.x + 2);
            y = y + (param1.clip.bounds.y + 2 + _loc5_);
            return;
         }
      }
      
      public function updatePosition(param1:Node) : void
      {
         var _loc5_:* = null;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         var _loc2_:TextFieldDataExtension = TextFieldDataExtension.fromAsset(param1.clip.resource);
         var _loc4_:ClipTextField = !!_loc2_?_loc2_.getClipTextField(param1.clip):null;
         if(_useTextFieldTextRenderer)
         {
            _loc5_ = FontUtils.getNativeTextFieldMetrics(_loc4_.fontHeight);
            _loc3_ = FontUtils.getGameFontBaselineBySize(_loc4_.fontHeight);
            _loc6_ = Math.round(_loc3_ - _loc5_.ascent) - HeroesThemeBase.NATIVE_FONT_SIZE_OFFSET;
         }
         transformationMatrix = param1.state.matrix;
         alpha = param1.state.colorMode == 1?param1.state.colorAlpha:1;
         x = x + (param1.clip.bounds.x + 2);
         y = y + (param1.clip.bounds.y + 2 + _loc6_);
      }
      
      override public function get includeInLayout() : Boolean
      {
         return super.includeInLayout && visible;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(super.visible != param1)
         {
            .super.visible = param1;
            this.dispatchEventWith("layoutDataChange");
         }
      }
      
      public function get textWidth() : Number
      {
         var _loc4_:* = null;
         validate();
         var _loc2_:ITextRenderer = this.textRenderer;
         if(_loc2_ is SpecialTextRenderer)
         {
            _loc4_ = (_loc2_ as SpecialTextRenderer).textFormat;
         }
         else if(_loc2_ is BitmapFontTextRenderer)
         {
            _loc4_ = (_loc2_ as BitmapFontTextRenderer).textFormat;
         }
         if(!_loc4_)
         {
            return 0;
         }
         var _loc1_:Number = this.explicitWidth;
         var _loc3_:Number = this.explicitHeight;
         this.width = NaN;
         _loc2_.width = NaN;
         _loc2_.height = NaN;
         _loc2_.measureText(helperPoint);
         this.width = _loc1_;
         this.height = _loc3_;
         validate();
         return helperPoint.x;
      }
      
      public function get textWidthMultiline() : Number
      {
         var _loc3_:* = null;
         validate();
         var _loc1_:ITextRenderer = this.textRenderer;
         if(_loc1_ is SpecialTextRenderer)
         {
            _loc3_ = (_loc1_ as SpecialTextRenderer).textFormat;
         }
         else if(_loc1_ is BitmapFontTextRenderer)
         {
            _loc3_ = (_loc1_ as BitmapFontTextRenderer).textFormat;
         }
         if(!_loc3_)
         {
            return 0;
         }
         var _loc2_:Number = this.explicitHeight;
         _loc1_.height = NaN;
         _loc1_.measureText(helperPoint);
         this.height = _loc2_;
         validate();
         return helperPoint.x;
      }
      
      public function resetSize() : void
      {
         var _loc2_:* = null;
         validate();
         var _loc1_:ITextRenderer = this.textRenderer;
         if(_loc1_ is SpecialTextRenderer)
         {
            _loc2_ = (_loc1_ as SpecialTextRenderer).textFormat;
         }
         else if(_loc1_ is BitmapFontTextRenderer)
         {
            (_loc1_ as BitmapFontTextRenderer).truncateToFit = false;
            _loc2_ = (_loc1_ as BitmapFontTextRenderer).textFormat;
         }
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.size != ctf.fontHeight)
         {
            this.invalidate("styles");
            _loc2_.size = ctf.fontHeight;
            validate();
         }
      }
      
      public function adjustSizeToFitWidth(param1:Number = NaN) : void
      {
         var _loc6_:* = null;
         var _loc4_:* = NaN;
         var _loc5_:int = 0;
         validate();
         var _loc3_:ITextRenderer = this.textRenderer;
         if(!_loc3_ || !node)
         {
            return;
         }
         if(_loc3_ is SpecialTextRenderer)
         {
            _loc6_ = (_loc3_ as SpecialTextRenderer).textFormat;
         }
         else if(_loc3_ is BitmapFontTextRenderer)
         {
            (_loc3_ as BitmapFontTextRenderer).truncateToFit = false;
            _loc6_ = (_loc3_ as BitmapFontTextRenderer).textFormat;
         }
         if(!_loc6_)
         {
            return;
         }
         if(param1 == param1)
         {
            _loc4_ = param1;
         }
         else
         {
            _loc5_ = _loc6_.align == "center"?4:2;
            _loc4_ = Number(node.clip.bounds.width - _loc5_);
         }
         explicitWidth = NaN;
         _loc3_.width = NaN;
         _loc3_.height = NaN;
         if(_loc6_.size != ctf.fontHeight)
         {
            this.invalidate("styles");
            _loc6_.size = ctf.fontHeight;
         }
         _loc3_.measureText(helperPoint);
         if(helperPoint.x > _loc4_)
         {
            while(helperPoint.x > _loc4_ && _loc6_.size > 0)
            {
               _loc6_.size = _loc6_.size - 1;
               _loc3_.measureText(helperPoint);
            }
         }
         var _loc2_:* = _loc6_.align == "center";
         if(_loc2_)
         {
            this.width = _loc4_;
            this.invalidate("size");
         }
         validate();
      }
      
      protected function initTextFormat(param1:ClipTextField) : void
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
      
      protected function createFilter() : void
      {
         filter = LabelStyle.createDropShadowFilter();
      }
   }
}
