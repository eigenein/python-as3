package game.mechanics.clan_war.popup.log
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.clan_war.model.ClanWarDefenderValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ClanWarLogBattlePlayerPanelClip extends GuiClipNestedContainer
   {
       
      
      public var player_portrait:PlayerPortraitClip;
      
      public var tf_name:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public function ClanWarLogBattlePlayerPanelClip(param1:int = 1)
      {
         player_portrait = new PlayerPortraitClip();
         tf_name = new ClipLabel();
         tf_power = new ClipLabel();
         player_portrait.portrait.direction = param1;
         super();
      }
      
      public function setData(param1:ClanWarDefenderValueObject) : void
      {
         if(param1)
         {
            player_portrait.setData(param1.user);
            tf_name.text = !!param1.user?param1.user.nickname:param1.userId;
            tf_power.text = Translate.translate("UI_COMMON_HERO_POWER_COLON") + String(param1.teamPower);
         }
      }
   }
}
