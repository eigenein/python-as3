package game.mechanics.titan_arena.popup.chest
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.refillable.CostButton;
   
   public class TitanArtifactChestPopupClip extends PopupClipBase
   {
       
      
      public var tf_drop:ClipLabel;
      
      public var tf_drop_pack1:ClipLabel;
      
      public var tf_drop_pack2:ClipLabel;
      
      public var tf_drop_column1:ClipLabel;
      
      public var tf_drop_column2:ClipLabel;
      
      public var tf_drop_column3:ClipLabel;
      
      public var layout_spirit_artifacts:ClipLayout;
      
      public var layout_artifacts1:ClipLayout;
      
      public var layout_artifacts2:ClipLayout;
      
      public var layout_artifacts3:ClipLayout;
      
      public var slots_bg:GuiClipScale9Image;
      
      public var cost_button_pack100:CostButton;
      
      public var cost_button_pack_key:CostButton;
      
      public var cost_button_pack:CostButton;
      
      public var cost_button_single:CostButton;
      
      public var buttons_layout_group:ClipLayout;
      
      public var tf_open_single:ClipLabel;
      
      public var tf_open_pack_key:ClipLabel;
      
      public var tf_open_pack:ClipLabel;
      
      public var tf_open_pack100:ClipLabel;
      
      public var labels_layout_group:ClipLayout;
      
      public var anim_idle:GuiAnimation;
      
      public function TitanArtifactChestPopupClip()
      {
         tf_drop = new ClipLabel();
         tf_drop_pack1 = new ClipLabel();
         tf_drop_pack2 = new ClipLabel();
         tf_drop_column1 = new ClipLabel();
         tf_drop_column2 = new ClipLabel();
         tf_drop_column3 = new ClipLabel();
         layout_spirit_artifacts = ClipLayout.tiledMiddleCentered(22);
         layout_artifacts1 = ClipLayout.tiled(10);
         layout_artifacts2 = ClipLayout.verticalCenter(10);
         layout_artifacts3 = ClipLayout.verticalCenter(10);
         slots_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         cost_button_pack100 = new CostButton();
         cost_button_pack_key = new CostButton();
         cost_button_pack = new CostButton();
         cost_button_single = new CostButton();
         buttons_layout_group = ClipLayout.horizontalMiddleCentered(4,cost_button_single,cost_button_pack_key,cost_button_pack,cost_button_pack100);
         tf_open_single = new ClipLabel();
         tf_open_pack_key = new ClipLabel();
         tf_open_pack = new ClipLabel();
         tf_open_pack100 = new ClipLabel();
         labels_layout_group = ClipLayout.horizontalMiddleCentered(6,tf_open_single,tf_open_pack_key,tf_open_pack,tf_open_pack100);
         anim_idle = new GuiAnimation();
         super();
      }
   }
}
