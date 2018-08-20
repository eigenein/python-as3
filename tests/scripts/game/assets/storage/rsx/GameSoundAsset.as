package game.assets.storage.rsx
{
   import game.sound.MusicSource;
   import game.sound.SoundSource;
   
   public class GameSoundAsset
   {
      
      public static const IDENT:String = "game_sound";
       
      
      private var game_sound:RsxGuiAsset;
      
      public function GameSoundAsset()
      {
         super();
      }
      
      public function get dailyBonus() : SoundSource
      {
         return create("daily_bonus",0.35);
      }
      
      public function get evolutionHero() : SoundSource
      {
         return create("evolution_hero");
      }
      
      public function get heroUp() : SoundSource
      {
         return create("hero_up");
      }
      
      public function get incomeMessage() : SoundSource
      {
         return create("income");
      }
      
      public function get lvlUp() : SoundSource
      {
         return create("lvl_up");
      }
      
      public function get shopHover() : SoundSource
      {
         return create("cash_background");
      }
      
      public function get portalHover() : SoundSource
      {
         return create("potrtal03",0.5);
      }
      
      public function get pyramidHover() : SoundSource
      {
         return create("pyramid2",0.5);
      }
      
      public function get towerHover() : SoundSource
      {
         return create("tower_over",0.5);
      }
      
      public function get arenaHover() : SoundSource
      {
         return create("arena_back",0.1);
      }
      
      public function get grandArenaHover() : SoundSource
      {
         return create("magic_fire_9",0.4);
      }
      
      public function get buySuccess() : SoundSource
      {
         return create("cheers_10",0.2);
      }
      
      public function get battleMusic() : SoundSource
      {
         return createMusic("music_battle",1,true);
      }
      
      public function get battleWin() : SoundSource
      {
         return create("battle_win");
      }
      
      public function get alchemyWheel() : SoundSource
      {
         return create("alchemy_rotation_seq");
      }
      
      public function get winterTreeHover() : SoundSource
      {
         return create("window_ny_v2");
      }
      
      public function get zeppelinHover() : SoundSource
      {
         return create("zeppelin_atmo2",0.9,false);
      }
      
      public function get titanArtifactChest() : SoundSource
      {
         return create("elements_altar_seq",0.9,false);
      }
      
      public function get artifactChest() : SoundSource
      {
         return create("chest_artifact",0.9,false);
      }
      
      public function get artifactChestLootAverage() : SoundSource
      {
         return create("loot_average",0.9,false);
      }
      
      public function get artifactChestLootEpic() : SoundSource
      {
         return create("loot_epic",0.9,false);
      }
      
      public function get bossChest() : SoundSource
      {
         return create("boss_chest",0.9,false);
      }
      
      public function get bossChestShort() : SoundSource
      {
         return create("boss_chest_short",0.9,false);
      }
      
      public function init(param1:RsxGuiAsset) : void
      {
         this.game_sound = param1;
      }
      
      protected function create(param1:String, param2:Number = 1, param3:Boolean = false) : SoundSource
      {
         return new SoundSource(game_sound.getSound(param1),param3,param2);
      }
      
      protected function createMusic(param1:String, param2:Number = 1, param3:Boolean = false) : SoundSource
      {
         return new MusicSource(game_sound.getSound(param1),param3,param2);
      }
   }
}
