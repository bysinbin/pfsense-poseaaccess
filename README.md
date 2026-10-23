# PoseaAccess for pfSense &bull; Kullanıcı, Cihaz Yetkilendirme & İstisna Masası

PoseaAccess, ağınızdaki kullanıcıların mesai saatlerine göre yetkilendirilmesini, MAC adresi tabanlı cihaz denetimini ve engelleme sayfasından gelen yetki/istisna taleplerinin tek tıkla onaylanmasını sağlayan bağımsız bir pfSense paketidir.

## 🚀 Özellikler
- **Mesai Saatleri & Çizelge:** Çalışma saatleri ve günleri belirleme, mesai dışı otomatik esneklik sağlama.
- **Cihaz (MAC) Filtreleme:** Beyaz Liste veya Kara Liste ile donanım seviyesinde erişim denetimi.
- **İstisna & Erişim Talepleri Onay Masası:** Engellenen kullanıcıların blok sayfasından gönderdiği formları listeleme, 1 saatlik / 1 günlük veya kalıcı olarak tek tıkla onaylama.
- **Aç/Kapa Anahtarı:** İçindeki enable seçeneği ile dilediğiniz zaman tek tıkla aktif veya pasif edilebilir.

## 📦 Kurulum (Tek Komut)
pfSense SSH konsolunda root olarak çalıştırın:
```sh
curl -sSL https://raw.githubusercontent.com/bysinbin/pfsense-poseaaccess/main/scripts/install.sh | sh
```
Kurulum tamamlandığında pfSense WebGUI üzerinde **Services > PoseaAccess** menüsü belirecektir.
