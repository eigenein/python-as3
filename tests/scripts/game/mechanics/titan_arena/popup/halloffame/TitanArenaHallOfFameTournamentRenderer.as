package game.mechanics.titan_arena.popup.halloffame
{
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class TitanArenaHallOfFameTournamentRenderer extends ListItemRenderer
   {
       
      
      private var clip:TitanArenaHallOfFameTournamentRendererClip;
      
      public function TitanArenaHallOfFameTournamentRenderer()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.width = 200;
         clip = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaHallOfFameTournamentRendererClip,"titan_arena_hall_of_frame_tournament_renderer");
         addChild(clip.container);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid("data") && data && clip)
         {
            clip.tf_text.text = String(data);
         }
      }
   }
}
