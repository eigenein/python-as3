package game.mechanics.grand.popup.log
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class GrandLogListItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var button_select:ClipButtonLabeled;
      
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
      
      public function GrandLogListItemRendererClip()
      {
         button_select = new ClipButtonLabeled();
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
         super();
      }
   }
}
