package game.battle.gui
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.model.user.UserInfo;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class BattleUserPanel extends GuiClipNestedContainer
   {
       
      
      private var user:UserInfo;
      
      private var graphicsInitialized:Boolean;
      
      public var portrait:PlayerPortraitClip;
      
      public var tf_nickname:SpecialClipLabel;
      
      public var tf_clan:SpecialClipLabel;
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var clan_icon_bg:ClipSpriteUntouchable;
      
      public var bg:BattleUserPanelBackground;
      
      public function BattleUserPanel()
      {
         portrait = new PlayerPortraitClip();
         tf_nickname = new SpecialClipLabel();
         tf_clan = new SpecialClipLabel();
         clan_icon = new ClanIconWithFrameClip();
         clan_icon_bg = new ClipSpriteUntouchable();
         bg = new BattleUserPanelBackground();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         graphicsInitialized = true;
         graphics.touchable = false;
         if(user != null)
         {
            setUser(user);
         }
      }
      
      public function setUser(param1:UserInfo) : void
      {
         this.user = param1;
         if(!graphicsInitialized)
         {
            return;
         }
         if(param1 != null)
         {
            tf_nickname.text = param1.nickname;
            portrait.setData(param1);
            if(param1.clanInfo)
            {
               tf_clan.text = param1.clanInfo.title;
               clan_icon.setData(param1.clanInfo,false);
               setClanIconVisibility(true);
            }
            else
            {
               setClanIconVisibility(false);
            }
         }
         else
         {
            tf_nickname.text = "?";
            setClanIconVisibility(false);
         }
      }
      
      protected function setClanIconVisibility(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         tf_clan.visible = param1;
         clan_icon.graphics.visible = param1;
         clan_icon_bg.graphics.visible = param1;
         bg.bg_clan.graphics.visible = param1;
         bg.bg_no_clan.graphics.visible = !param1;
         if(param1)
         {
            tf_nickname.graphics.x = tf_clan.graphics.x;
         }
         else
         {
            _loc2_ = clan_icon.graphics.x > tf_nickname.graphics.x?1:-1;
            tf_nickname.graphics.x = tf_clan.graphics.x + _loc2_ * 30;
         }
      }
   }
}
