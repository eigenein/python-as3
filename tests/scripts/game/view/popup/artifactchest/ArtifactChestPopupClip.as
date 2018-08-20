package game.view.popup.artifactchest
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.refillable.CostButton;
   
   public class ArtifactChestPopupClip extends PopupClipBase
   {
       
      
      public var tf_drop:ClipLabel;
      
      public var tf_drop_pack1:ClipLabel;
      
      public var tf_drop_pack2:ClipLabel;
      
      public var tf_drop_pack3:ClipLabel;
      
      public var slot:Vector.<GuiClipContainer>;
      
      public var slots_bg:GuiClipScale9Image;
      
      public var tf_level:ClipLabel;
      
      public var progressbar:ArtifactChestProgressBarClip;
      
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
      
      public function ArtifactChestPopupClip()
      {
         tf_drop = new ClipLabel();
         tf_drop_pack1 = new ClipLabel();
         tf_drop_pack2 = new ClipLabel();
         tf_drop_pack3 = new ClipLabel();
         slot = new Vector.<GuiClipContainer>();
         slots_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         tf_level = new ClipLabel();
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
