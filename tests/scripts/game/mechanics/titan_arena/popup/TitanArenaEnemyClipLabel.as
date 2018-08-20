package game.mechanics.titan_arena.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import feathers.layout.VerticalLayout;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import starling.events.Event;
   
   public class TitanArenaEnemyClipLabel extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var darkness:ClipSprite;
      
      public var divider_line:GuiClipScale3Image;
      
      public var icon_power:ClipSprite;
      
      public var layout_teams:ClipLayout;
      
      public var layout_block:ClipLayout;
      
      public function TitanArenaEnemyClipLabel()
      {
         tf_header = new ClipLabel(true);
         tf_power = new ClipLabel(true);
         darkness = new ClipSprite();
         divider_line = new GuiClipScale3Image();
         icon_power = new ClipSprite();
         layout_teams = ClipLayout.horizontalMiddleCentered(1,icon_power,tf_power);
         layout_block = ClipLayout.verticalCenter(0,tf_header,layout_teams);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_teams.width = NaN;
         layout_block.width = NaN;
         layout_block.addEventListener("resize",handler_resizeLayout);
         var _loc2_:VerticalLayout = layout_block.layout as VerticalLayout;
         var _loc3_:int = 18;
         _loc2_.paddingLeft = _loc3_;
         _loc2_.paddingRight = _loc3_;
      }
      
      private function handler_resizeLayout(param1:Event) : void
      {
         layout_block.x = int(-layout_block.width / 2);
         divider_line.graphics.width = layout_block.width;
         divider_line.graphics.x = layout_block.x;
      }
   }
}
