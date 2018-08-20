package game.view.popup.arena.log
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ArenaLogItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var btn_camera:ClipButton;
      
      public var btn_chat:ClipButton;
      
      public var btn_info:ClipButtonLabeled;
      
      public var buttons_layout:ClipLayout;
      
      public var tf_date:ClipLabel;
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var tf_nickname:ClipLabel;
      
      public var tf_place_down:ClipLabel;
      
      public var tf_place_up:ClipLabel;
      
      public var tf_attack_defeat:ClipLabel;
      
      public var tf_attack_victory:ClipLabel;
      
      public var tf_defence_defeat:ClipLabel;
      
      public var tf_defence_victory:ClipLabel;
      
      public var tf_draw:ClipLabel;
      
      public var arrow_green:ClipSprite;
      
      public var arrow_red:ClipSprite;
      
      public var portrait:PlayerPortraitClip;
      
      public var bg:GuiClipScale9Image;
      
      public function ArenaLogItemRendererClip()
      {
         btn_camera = new ClipButton();
         btn_chat = new ClipButton();
         btn_info = new ClipButtonLabeled();
         buttons_layout = ClipLayout.horizontalMiddleCentered(5,btn_chat,btn_info,btn_camera);
         tf_date = new ClipLabel(true);
         clan_icon = new ClanIconWithFrameClip();
         tf_nickname = new ClipLabel();
         tf_place_down = new ClipLabel();
         tf_place_up = new ClipLabel();
         tf_attack_defeat = new ClipLabel();
         tf_attack_victory = new ClipLabel();
         tf_defence_defeat = new ClipLabel();
         tf_defence_victory = new ClipLabel();
         tf_draw = new ClipLabel();
         arrow_green = new ClipSprite();
         arrow_red = new ClipSprite();
         portrait = new PlayerPortraitClip();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
