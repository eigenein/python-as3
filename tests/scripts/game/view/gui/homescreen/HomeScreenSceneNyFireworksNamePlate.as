package game.view.gui.homescreen
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class HomeScreenSceneNyFireworksNamePlate extends GuiClipNestedContainer
   {
       
      
      public var tf_clan_title:ClipLabel;
      
      public var tf_label:ClipLabel;
      
      public var tf_name:ClipLabel;
      
      public var clan_icon_bg:ClipSprite;
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var buffSuperslot_6_6_1_inst0:GuiClipScale3Image;
      
      public var layout_text:ClipLayout;
      
      public var layout_secret:ClipLayout;
      
      public function HomeScreenSceneNyFireworksNamePlate()
      {
         tf_clan_title = new ClipLabel(true);
         tf_label = new ClipLabel(true);
         tf_name = new ClipLabel(true);
         clan_icon_bg = new ClipSprite();
         clan_icon = new ClanIconWithFrameClip();
         buffSuperslot_6_6_1_inst0 = new GuiClipScale3Image(6,1);
         layout_text = ClipLayout.verticalMiddleLeft(0,tf_name,tf_clan_title,tf_label);
         layout_secret = ClipLayout.none();
         super();
      }
   }
}
