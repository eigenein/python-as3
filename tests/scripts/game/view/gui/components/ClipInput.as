package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.extension.TextFieldDataExtension;
   import com.progrestar.framework.ares.extension.textfield.ClipTextField;
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import engine.core.clipgui.IGuiClip;
   import feathers.controls.TextInput;
   import feathers.text.BitmapFontTextFormat;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import game.view.popup.theme.LabelStyle;
   import starling.display.DisplayObject;
   
   public class ClipInput extends TextInput implements IGuiClip
   {
       
      
      private var autoSize:Boolean;
      
      private var showDelayId:int;
      
      private var _promptShowDelay:Number = 0;
      
      public function ClipInput(param1:Boolean = false)
      {
         super();
         this.autoSize = param1;
      }
      
      public function get graphics() : DisplayObject
      {
         return !!parent?null:this;
      }
      
      public function get container() : DisplayObject
      {
         return this;
      }
      
      public function set promptShowDelay(param1:Number) : *
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         _promptShowDelay = param1;
      }
      
      public function setNode(param1:Node) : void
      {
         var _loc5_:int = 0;
         var _loc2_:TextFieldDataExtension = TextFieldDataExtension.fromAsset(param1.clip.resource);
         var _loc3_:ClipTextField = !!_loc2_?_loc2_.getClipTextField(param1.clip):null;
         if(!_loc2_ || !_loc3_)
         {
            return;
            §§push(trace(this + "Для клипа ассета с клипом " + param1.clip.className + " не определена TextFieldData"));
         }
         else
         {
            textEditorProperties.fontFamily = _loc3_.fontClass;
            textEditorProperties.fontSize = _loc3_.fontHeight;
            textEditorProperties.color = _loc3_.textColor;
            textEditorProperties.multiline = _loc3_.multiline;
            var _loc4_:BitmapFontTextFormat = LabelStyle.fromClipTextField(_loc3_);
            _loc4_.color = 8417875;
            promptProperties.textFormat = _loc4_;
            filter = LabelStyle.createDropShadowFilter();
            if(!autoSize)
            {
               _loc5_ = _loc3_.align == 2?4:2;
               width = param1.clip.bounds.width - _loc5_;
               height = param1.clip.bounds.height - 2;
               StarlingClipNode.applyState(this,param1.state);
               x = x + (param1.clip.bounds.x + 2);
               y = y + (param1.clip.bounds.y + 2);
            }
            else
            {
               StarlingClipNode.applyState(this,param1.state);
               x = x + (param1.clip.bounds.x + 2);
               y = y + (param1.clip.bounds.y + 2);
            }
            return;
         }
      }
      
      override protected function draw() : void
      {
         var _loc6_:Boolean = false;
         var _loc5_:Boolean = this.isInvalid("state");
         var _loc7_:Boolean = this.isInvalid("styles");
         var _loc8_:Boolean = this.isInvalid("data");
         var _loc3_:Boolean = this.isInvalid("skin");
         var _loc1_:Boolean = this.isInvalid("size");
         var _loc9_:Boolean = this.isInvalid("textEditor");
         var _loc4_:Boolean = this.isInvalid("promptFactory");
         var _loc2_:Boolean = this.isInvalid("focus");
         super.draw();
         if(this.promptTextRenderer)
         {
            _loc6_ = false;
            if(_loc4_ || _loc8_ || _loc7_ || _loc2_)
            {
               _loc6_ = this._prompt && this._text.length == 0 && !this.hasFocus;
            }
            if(_loc4_ || _loc5_)
            {
               _loc6_ = this._prompt && this._text.length == 0 && !this.hasFocus;
               this.promptTextRenderer.isEnabled = this._isEnabled;
            }
            if(_loc6_ != this.promptTextRenderer.visible)
            {
               clearTimeout(showDelayId);
               if(_promptShowDelay > 0 && _loc6_)
               {
                  showDelayId = setTimeout(showPrompt,_promptShowDelay * 1000);
               }
               else
               {
                  this.promptTextRenderer.visible = _loc6_;
               }
            }
         }
      }
      
      private function showPrompt() : void
      {
         this.promptTextRenderer.visible = true;
      }
   }
}
