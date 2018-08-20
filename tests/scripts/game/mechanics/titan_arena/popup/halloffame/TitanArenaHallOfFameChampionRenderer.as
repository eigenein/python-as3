package game.mechanics.titan_arena.popup.halloffame
{
   import game.assets.storage.AssetStorage;
   import game.mechanics.titan_arena.model.TitanArenaHallOfFameUserInfo;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class TitanArenaHallOfFameChampionRenderer extends ListItemRenderer
   {
       
      
      protected var clip:TitanArenaHallOfFameChampionRendererClip;
      
      public function TitanArenaHallOfFameChampionRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(clip)
         {
            clip.dispose();
         }
         super.dispose();
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         clip.commitData(data as TitanArenaHallOfFameUserInfo);
         addChild(clip.graphics);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaHallOfFameChampionRendererClip,"titan_arena_hall_of_frame_champion_renderer");
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
      }
   }
}
