package game.mechanics.titan_arena.popup.raid
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.specialoffer.welcomeback.ClipLabelInContainer;
   
   public class TitanArenaRaidStartPopupClip extends PopupClipBase
   {
       
      
      public const tf_header:ClipLabel = new ClipLabel();
      
      public const tf_attackers_header:ClipLabel = new ClipLabel();
      
      public const tf_attackers_desc:ClipLabel = new ClipLabel();
      
      public const tf_defenders_header:ClipLabel = new ClipLabel();
      
      public const tf_defenders_desc:ClipLabel = new ClipLabel();
      
      public const block_attackers:TitanArenaRaidStartTeamBlockClip = new TitanArenaRaidStartTeamBlockClip();
      
      public const block_defenders:TitanArenaRaidStartTeamBlockClip = new TitanArenaRaidStartTeamBlockClip();
      
      public const block_defenders_text:ClipLabelInContainer = new ClipLabelInContainer();
      
      public const button_start:ClipButtonLabeled = new ClipButtonLabeled();
      
      public function TitanArenaRaidStartPopupClip()
      {
         super();
      }
   }
}
