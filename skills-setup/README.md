# Bộ skill Claude Code cho code và dựng video bằng AI

Tổng hợp từ 4 video TikTok (@aidev.repo, @danhtuanaaa247, @qafweb, @h2_dev) và bảng xếp hạng skill của @george.automates.

## Cài đặt nhanh

Yêu cầu: đã đăng nhập Claude Code (`claude` chạy được), có Node.js 22+, Git, FFmpeg. Script sẽ tự cài những thứ còn thiếu.

**Windows** (mở PowerShell trong thư mục này):
```powershell
powershell -ExecutionPolicy Bypass -File .\install-windows.ps1
```

**macOS / Linux**:
```bash
bash install-mac-linux.sh
```

Cuối script có bảng tổng kết lệnh nào lỗi. Cài xong thì **khởi động lại Claude Code** và gõ `/plugin` để kiểm tra.

## Những gì được cài

| Hạng | Skill | Dùng để làm gì | Nguồn |
|---|---|---|---|
| S+ | **Superpowers** | Quy trình 7 bước: brainstorm → plan → TDD → review. Skill tự kích hoạt | obra/superpowers |
| S+ | **HyperFrames** | Dựng video bằng HTML/CSS/GSAP, preview và render ra MP4 | heygen-com/hyperframes |
| S+ | **Skill Creator** | Tự tạo skill riêng cho bạn | anthropics/skills |
| S+ | **UI UX Pro Max** | Gợi ý thiết kế giao diện chuyên nghiệp | nextlevelbuilder/ui-ux-pro-max-skill |
| A | **Caveman** | Trả lời ngắn gọn, tiết kiệm token | JuliusBrussee/caveman |
| A | **Herk Edit Kit** | Cắt khoảng lặng, cắt lỗi nói, phụ đề, B-roll, reel 9:16 | nateherkai/herk-edit-kit |
| A | **Humanizer** | Xoá "giọng AI" trong văn bản | blader/humanizer |
| A | **Frontend Design** | Giao diện web đẹp, không rập khuôn | anthropics/skills |
| B | **Remotion Best Practices** | Dựng video bằng React (Remotion) | remotion-dev/skills |
| B | **React Best Practices** | Chuẩn viết React/Next.js | vercel-labs/agent-skills |
| B | **Marketing Skills** | Copywriting, SEO, CRO | coreyhaines31/marketingskills |
| Video 2 | **Playwright CLI** | Claude tự mở trình duyệt để kiểm tra giao diện | microsoft/playwright-cli |
| Video 2 | **Ponytail** | Viết code tối giản, ít token hơn | DietrichGebert/ponytail |
| Video 2 | **Graphify** | Biến mã nguồn thành bản đồ tri thức | Graphify-Labs/graphify |
| Video 2 | **Agent Skills** | Bộ skill kỹ thuật: plan → code → test | addyosmani/agent-skills |

Không cài: hạng C và D (PDF, Canvas, SEO Audit, Theme Factory, Algorithmic Art, Slack GIF), vì bảng xếp hạng đánh giá là ít giá trị.

**OmniRoute** (video 2) không nằm trong script. Đây là một proxy định tuyến qua nhiều nhà cung cấp AI miễn phí. Nó chạy thường trực trên máy và đi qua tài khoản bên thứ ba, nên chỉ nên cài nếu bạn hiểu rõ điều khoản của các nhà cung cấp đó: `npm install -g omniroute`.

## Dựng video như trong video 3 và 4

Trong video 3 và 4, Claude Code điều khiển một timeline nhiều track, cắt ghép rồi render. Đó chính là quy trình HyperFrames kết hợp Herk Edit Kit.

1. Mở thư mục `~/herk-edit-kit` (Windows: `C:\Users\<tên>\herk-edit-kit`) bằng Claude Code:
   ```bash
   cd ~/herk-edit-kit
   claude
   ```
2. Thử bản demo:
   ```
   npm run demo
   cd video-projects/demo
   npx hyperframes preview     # xem trước trên trình duyệt
   npx hyperframes render --quality draft --output renders/demo.mp4
   ```
3. Dựng từ footage của bạn. Gõ trong Claude Code:
   > /edit-video Dựng video từ file D:\quay\video1.mp4. Cắt khoảng lặng, đề xuất các chỗ nói vấp để mình duyệt, thêm phụ đề tiếng Việt, dùng nền graph-paper tối. Xuất bản nháp để mình xem.

   Làm reel hoặc TikTok 9:16:
   > /short-form-edit Biến file D:\quay\video1.mp4 thành reel 9:16 có hook mạnh ở 3 giây đầu, phụ đề chính xác từng từ, B-roll và hiệu ứng âm thanh.

   Video giải thích dạng animation như video 1 và 2 (không cần footage):
   > Dùng hyperframes làm video dọc 1080x1920 dài 45 giây giới thiệu 5 skill Claude Code, có nhân vật hoạt hình, phụ đề tiếng Việt và thanh tiến độ 1/5…5/5.

### Chuyển giọng nói thành chữ (để làm phụ đề)
Herk Edit Kit mặc định dùng ElevenLabs Scribe (cần API key trong file `.env`). Không muốn trả phí thì bảo Claude dùng Whisper chạy trên máy:
```bash
pip install faster-whisper
```

## Một số câu lệnh hay dùng

- `/brainstorm` (Superpowers): bàn ý tưởng trước khi code
- `/caveman`: bật chế độ trả lời siêu ngắn
- `/humanizer`: viết lại văn bản cho tự nhiên
- `graphify .`: tạo bản đồ cho dự án hiện tại
- `playwright-cli open https://localhost:3000`: Claude tự soi giao diện
