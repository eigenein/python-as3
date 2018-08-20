package game.view.popup.team
{
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.MiniHeroTeamRenderer;
   
   public class GrandTeamGatherAttackPopupGuiClip extends GrandTeamGatherPopupGuiClip
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_enemy_power:ClipLabel;
      
      public var tf_label_enemy_team:ClipLabel;
      
      public var tf_label_enemy_team_hidden:ClipLabel;
      
      public var enemy_team_list:MiniHeroTeamRenderer;
      
      public function GrandTeamGatherAttackPopupGuiClip()
      {
         tf_header = new ClipLabel();
         tf_enemy_power = new ClipLabel();
         tf_label_enemy_team = new ClipLabel();
         tf_label_enemy_team_hidden = new ClipLabel();
         enemy_team_list = new MiniHeroTeamRenderer();
         super();
      }
   }
}
