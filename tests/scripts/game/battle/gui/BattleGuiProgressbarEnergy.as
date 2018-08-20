package game.battle.gui
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   
   public class BattleGuiProgressbarEnergy extends GuiClipNestedContainer
   {
       
      
      private var _minWidth:Number;
      
      private var _maxWidth:Number;
      
      public var full:GuiClipScale3Image;
      
      public var fill:GuiClipScale3Image;
      
      public var bg:GuiClipScale3Image;
      
      public function BattleGuiProgressbarEnergy(param1:int)
      {
         full = new GuiClipScale3Image();
         fill = new GuiClipScale3Image();
         bg = new GuiClipScale3Image();
         super();
         this._minWidth = param1;
      }
      
      public function set value(param1:Number) : void
      {
         if(param1 <= 0)
         {
            full.graphics.visible = false;
            fill.graphics.visible = false;
         }
         else if(param1 >= 1)
         {
            full.graphics.visible = true;
            fill.graphics.visible = false;
         }
         else
         {
            full.graphics.visible = false;
            fill.graphics.visible = true;
            fill.graphics.width = int(_minWidth + (_maxWidth - _minWidth) * param1);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         _maxWidth = fill.graphics.width;
      }
   }
}
