package game.assets.battle
{
   import engine.core.assets.AssetProvider;
   import engine.core.assets.FileDependentAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.sound.MusicSource;
   
   public class SoundtrackAsset extends FileDependentAsset
   {
       
      
      private var asset:String;
      
      private var ident:String;
      
      private var _musicSource:MusicSource;
      
      private var rsxAsset:RsxGameAsset;
      
      public function SoundtrackAsset(param1:String, param2:String)
      {
         super();
         this.asset = param1;
         this.ident = param2;
      }
      
      public function dispose() : void
      {
         if(rsxAsset)
         {
            rsxAsset.dropUsage();
         }
         if(_musicSource)
         {
            _musicSource = null;
         }
      }
      
      public function get music() : MusicSource
      {
         return _musicSource;
      }
      
      override public function get completed() : Boolean
      {
         return _musicSource;
      }
      
      override public function prepare(param1:AssetProvider) : void
      {
         if(!rsxAsset)
         {
            rsxAsset = AssetStorage.rsx.getByName(asset);
            if(rsxAsset)
            {
               rsxAsset.addUsage();
            }
         }
         param1.request(this,rsxAsset);
      }
      
      override public function complete() : void
      {
         if(rsxAsset)
         {
            _musicSource = new MusicSource(rsxAsset.getSound(ident),true);
         }
      }
   }
}
