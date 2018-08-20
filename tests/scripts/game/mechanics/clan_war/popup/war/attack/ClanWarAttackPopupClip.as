package game.mechanics.clan_war.popup.war.attack
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ClanWarAttackPopupClip extends ClipAnimatedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var tf_desc:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_bonus:ClipLabel;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var scroll_bar:GameScrollBar;
      
      public var list:GameScrolledList;
      
      public var tf_tries:SpecialClipLabel;
      
      public var tf_points:ClipLabel;
      
      public var icon_VP:ClipSprite;
      
      public var vp_bg:GuiClipScale3Image;
      
      public var vp_bg2:GuiClipScale3Image;
      
      public var tf_label_total_points:ClipLabel;
      
      public var tf_points_total:ClipLabel;
      
      public var layout_victory_points_bonus:ClipLayout;
      
      public var layout_caption:ClipLayout;
      
      public function ClanWarAttackPopupClip()
      {
         button_close = new ClipButton();
         tf_desc = new ClipLabel();
         tf_header = new ClipLabel();
         tf_label_bonus = new ClipLabel();
         gradient_bottom = new ClipSpriteUntouchable();
         gradient_top = new ClipSpriteUntouchable();
         scroll_bar = new GameScrollBar();
         list = new GameScrolledList(scroll_bar,gradient_top.graphics,gradient_bottom.graphics);
         tf_tries = new SpecialClipLabel();
         tf_points = new ClipLabel();
         icon_VP = new ClipSprite();
         vp_bg = new GuiClipScale3Image(17,1);
         vp_bg2 = new GuiClipScale3Image(17,1);
         tf_label_total_points = new ClipLabel();
         tf_points_total = new ClipLabel();
         layout_victory_points_bonus = ClipLayout.none(vp_bg,tf_label_bonus,tf_points,icon_VP);
         layout_caption = ClipLayout.horizontalMiddleCentered(0,tf_tries);
         super();
      }
   }
}
