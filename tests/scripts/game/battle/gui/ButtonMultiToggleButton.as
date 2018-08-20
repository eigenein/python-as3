package game.battle.gui
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   
   public class ButtonMultiToggleButton extends GuiClipNestedContainer
   {
       
      
      public var button:ClipButtonLabeled;
      
      public var toggle_on:Vector.<GuiClipImage>;
      
      public var toggle_off:Vector.<GuiClipImage>;
      
      public function ButtonMultiToggleButton()
      {
         toggle_on = new Vector.<GuiClipImage>();
         toggle_off = new Vector.<GuiClipImage>();
         super();
      }
      
      public function set index(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = Math.min(toggle_off.length,toggle_on.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            toggle_on[_loc3_].graphics.visible = param1 == _loc3_;
            toggle_off[_loc3_].graphics.visible = param1 != _loc3_;
            _loc3_++;
         }
      }
   }
}
