package game.mechanics.titan_arena.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class TitanArenaPopupEnemySelectUIClip extends GuiClipNestedContainer
   {
       
      
      public const tf_stage:ClipLabel = new ClipLabel();
      
      public const tf_stage_desc:ClipLabel = new ClipLabel();
      
      public const bg_final_stage:ClipSprite = new ClipSprite();
      
      public const bg_stage:ClipSprite = new ClipSprite();
      
      public const tf_label_points:ClipLabel = new ClipLabel(true);
      
      public const tf_points:ClipLabel = new ClipLabel(true);
      
      public const tf_label_position:SpecialClipLabel = new SpecialClipLabel();
      
      public const tf_raid:ClipLabel = new ClipLabel();
      
      public const tf_select_enemy:ClipLabel = new ClipLabel();
      
      public const button_rules:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const button_shop:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const button_rating:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const button_raid:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const icon_points:ClipSprite = new ClipSprite();
      
      public const icon_points_adjust:ClipLayout = ClipLayout.horizontalLeft(0,icon_points);
      
      public const layout_points:ClipLayout = ClipLayout.horizontalMiddleLeft(2,tf_label_points,icon_points,tf_points);
      
      public const enemy_list:TitanArenaEnemyListClip = new TitanArenaEnemyListClip();
      
      public function TitanArenaPopupEnemySelectUIClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         icon_points_adjust.width = NaN;
         icon_points_adjust.width = icon_points_adjust.width;
         icon_points_adjust.height = NaN;
         icon_points_adjust.height = icon_points_adjust.height;
      }
   }
}
