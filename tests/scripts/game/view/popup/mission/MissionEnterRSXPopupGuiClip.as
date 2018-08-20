package game.view.popup.mission
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipLabel;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.text.BitmapFontTextFormat;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.theme.LabelStyle;
   import starling.filters.BlurFilter;
   
   public class MissionEnterRSXPopupGuiClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var lootpanel_bg:GuiClipScale9Image;
      
      public var enemypanel_bg:GuiClipScale9Image;
      
      public var inst0_mainframe_64_64_2_2:GuiClipScale9Image;
      
      public var item_list_container:GuiClipLayoutContainer;
      
      public var header_layout_container:GuiClipLayoutContainer;
      
      public var team_list_container:GuiClipLayoutContainer;
      
      public var raidpanel_layout_container:GuiClipLayoutContainer;
      
      public var star_layout_container:MissionStarDisplay;
      
      public var label_loot:GuiClipLabel;
      
      public var label_enemies:GuiClipLabel;
      
      public var button_tries_add:ClipButton;
      
      public var button_start:ClipButtonLabeled;
      
      public var tf_cost:ClipLabel;
      
      public var tf_cost_label:ClipLabel;
      
      public var tf_tries:ClipLabel;
      
      public var tf_tries_label:ClipLabel;
      
      public var tf_mission_desc:ClipLabel;
      
      public var icon:GuiClipImage;
      
      public var layout_elite_tries:ClipLayout;
      
      public var layout_energy_cost:ClipLayout;
      
      public var layout_secret:ClipLayoutNone;
      
      public function MissionEnterRSXPopupGuiClip()
      {
         button_tries_add = new ClipButton();
         button_start = new ClipButtonLabeled();
         tf_cost = new ClipLabel(true);
         tf_cost_label = new ClipLabel(true);
         tf_tries = new ClipLabel(true);
         tf_tries_label = new ClipLabel(true);
         tf_mission_desc = new ClipLabel();
         icon = new GuiClipImage();
         layout_elite_tries = ClipLayout.horizontalMiddleCentered(4,tf_tries_label,tf_tries,button_tries_add);
         layout_energy_cost = ClipLayout.horizontalMiddleCentered(-4,tf_cost_label,icon,tf_cost);
         layout_secret = new ClipLayoutNone();
         super();
         label_loot = new GuiClipLabel(LabelStyle.label_size18_center);
         label_enemies = new GuiClipLabel(LabelStyle.label_size18_center);
      }
      
      protected function createLabel() : GameLabel
      {
         var _loc1_:GameLabel = new GameLabel();
         _loc1_.textRendererProperties.textFormat = new BitmapFontTextFormat(AssetStorage.font.Officina14,18,16777215,"center");
         _loc1_.filter = BlurFilter.createDropShadow(2,3.14159265358979 / 2,0,0.5,0,1);
         return _loc1_;
      }
   }
}
