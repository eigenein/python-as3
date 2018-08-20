package game.view.gui.tutorial.dialogs
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.SpecialClipLabel;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.events.Event;
   
   public class TutorialMessageClip extends GuiClipNestedContainer
   {
       
      
      private var _animatedText:String;
      
      private var _animatedPosition:Number;
      
      private var _symbolPerSecond:Number = 70;
      
      public var tf_text:SpecialClipLabel;
      
      public var button_ok:ClipButtonLabeled;
      
      public var icon_container:GuiClipContainer;
      
      public var panel:GuiClipScale9Image;
      
      public var bubble:GuiClipScale9Image;
      
      public function TutorialMessageClip()
      {
         tf_text = new SpecialClipLabel(false,false,true);
         button_ok = new ClipButtonLabeled();
         icon_container = new GuiClipContainer();
         panel = new GuiClipScale9Image();
         bubble = new GuiClipScale9Image();
         super();
      }
      
      public function animateText(param1:String) : void
      {
         _animatedPosition = 0;
         _animatedText = param1;
         tf_text.text = param1;
         tf_text.validate();
         bubble.graphics.height = Math.max(62,tf_text.height + 21);
         tf_text.text = "";
         graphics.addEventListener("enterFrame",handler_enterFrame);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         var _loc2_:Number = _animatedPosition + param1.data * _symbolPerSecond;
         if(int(_loc2_) != int(_animatedPosition))
         {
            tf_text.text = _animatedText.slice(0,int(_loc2_)) + ColorUtils.hexToRGBFormat(16775894) + _animatedText.slice(int(_loc2_));
            if(int(_loc2_) == _animatedText.length)
            {
               graphics.removeEventListener("enterFrame",handler_enterFrame);
            }
         }
         _animatedPosition = _loc2_;
      }
   }
}
