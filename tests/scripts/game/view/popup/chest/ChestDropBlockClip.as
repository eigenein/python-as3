package game.view.popup.chest
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ChestDropBlockClip extends GuiClipNestedContainer
   {
       
      
      public var tf_drop_desc:ClipLabel;
      
      public var tf_hero_rest:ClipLabel;
      
      public var tf_gear_drop_list:ClipLabel;
      
      public var tf_gear_rest:ClipLabel;
      
      public var button_hero_list:ClipButton;
      
      public var list_label_container:ClipLayout;
      
      public var hero_bg:GuiClipScale9Image;
      
      public var gear_bg:GuiClipScale9Image;
      
      public var drop_bg:GuiClipScale9Image;
      
      public var hero_list:Vector.<ChestDropPresentationRenderer>;
      
      public var gear_list:Vector.<ChestDropPresentationRenderer>;
      
      public var special_hero_list:Vector.<ChestDropPresentationRendererSpecial>;
      
      public var coin_super_prize:ChestDropCoinSuperPrizeRenderer;
      
      public var desc_layout:ClipLayout;
      
      public function ChestDropBlockClip()
      {
         tf_drop_desc = new ClipLabel();
         tf_hero_rest = new ClipLabel();
         tf_gear_drop_list = new ClipLabel();
         tf_gear_rest = new ClipLabel(true);
         button_hero_list = new ClipButton();
         list_label_container = ClipLayout.horizontalMiddleCentered(2,tf_gear_rest,button_hero_list);
         hero_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         gear_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         drop_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         hero_list = new Vector.<ChestDropPresentationRenderer>();
         gear_list = new Vector.<ChestDropPresentationRenderer>();
         special_hero_list = new Vector.<ChestDropPresentationRendererSpecial>();
         desc_layout = ClipLayout.horizontalBottomCentered(0,tf_drop_desc);
         super();
      }
   }
}
