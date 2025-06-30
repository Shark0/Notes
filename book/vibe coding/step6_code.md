# Step6 Code
```
// Entity
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "rebate_setting")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RebateSetting {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "product_type", nullable = false)
    private String productType;
    
    @Column(name = "sub_product_type", nullable = false)
    private String subProductType;
    
    @Column(name = "system_name", nullable = false)
    private String systemName;
    
    @Column(name = "sub_system_name", nullable = false)
    private String subSystemName;
    
    @Column(name = "commission_parameter", nullable = false)
    private String commissionParameter;
    
    @Column(name = "order_product", nullable = false)
    private String orderProduct;
    
    @Column(name = "order_product_type", nullable = false)
    private String orderProductType;
    
    @Column(name = "commission_rate", nullable = false, precision = 12, scale = 6)
    private BigDecimal commissionRate;
    
    @Column(name = "rebate_rate", nullable = false, precision = 12, scale = 6)
    private BigDecimal rebateRate;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}

// Repository
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RebateSettingRepository extends JpaRepository<RebateSetting, Long> {
}

// Create Service
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CreateRebateSettingService {
    
    private final RebateSettingRepository rebateSettingRepository;
    
    public RebateSetting start(RebateSetting rebateSetting) {
        return rebateSettingRepository.save(rebateSetting);
    }
}

// Read Service (Get by ID)
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GetRebateSettingService {
    
    private final RebateSettingRepository rebateSettingRepository;
    
    public Optional<RebateSetting> start(Long id) {
        return rebateSettingRepository.findById(id);
    }
}

// Read Service (Get All)
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class GetAllRebateSettingsService {
    
    private final RebateSettingRepository rebateSettingRepository;
    
    public List<RebateSetting> start() {
        return rebateSettingRepository.findAll();
    }
}

// Update Service
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UpdateRebateSettingService {
    
    private final RebateSettingRepository rebateSettingRepository;
    
    public Optional<RebateSetting> start(Long id, RebateSetting updatedRebateSetting) {
        return rebateSettingRepository.findById(id)
                .map(existingSetting -> {
                    existingSetting.setProductType(updatedRebateSetting.getProductType());
                    existingSetting.setSubProductType(updatedRebateSetting.getSubProductType());
                    existingSetting.setSystemName(updatedRebateSetting.getSystemName());
                    existingSetting.setSubSystemName(updatedRebateSetting.getSubSystemName());
                    existingSetting.setCommissionParameter(updatedRebateSetting.getCommissionParameter());
                    existingSetting.setOrderProduct(updatedRebateSetting.getOrderProduct());
                    existingSetting.setOrderProductType(updatedRebateSetting.getOrderProductType());
                    existingSetting.setCommissionRate(updatedRebateSetting.getCommissionRate());
                    existingSetting.setRebateRate(updatedRebateSetting.getRebateRate());
                    return rebateSettingRepository.save(existingSetting);
                });
    }
}

// Delete Service
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DeleteRebateSettingService {
    
    private final RebateSettingRepository rebateSettingRepository;
    
    public boolean start(Long id) {
        if (rebateSettingRepository.existsById(id)) {
            rebateSettingRepository.deleteById(id);
            return true;
        }
        return false;
    }
}

// Controller
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/rebate-settings")
@RequiredArgsConstructor
public class RebateSettingController {
    
    private final CreateRebateSettingService createRebateSettingService;
    private final GetRebateSettingService getRebateSettingService;
    private final GetAllRebateSettingsService getAllRebateSettingsService;
    private final UpdateRebateSettingService updateRebateSettingService;
    private final DeleteRebateSettingService deleteRebateSettingService;
    
    // Create
    @PostMapping
    public ResponseEntity<RebateSetting> createRebateSetting(@RequestBody RebateSetting rebateSetting) {
        try {
            RebateSetting createdSetting = createRebateSettingService.start(rebateSetting);
            return new ResponseEntity<>(createdSetting, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    // Read - Get by ID
    @GetMapping("/{id}")
    public ResponseEntity<RebateSetting> getRebateSettingById(@PathVariable Long id) {
        Optional<RebateSetting> rebateSetting = getRebateSettingService.start(id);
        return rebateSetting.map(setting -> new ResponseEntity<>(setting, HttpStatus.OK))
                           .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }
    
    // Read - Get All
    @GetMapping
    public ResponseEntity<List<RebateSetting>> getAllRebateSettings() {
        try {
            List<RebateSetting> rebateSettings = getAllRebateSettingsService.start();
            if (rebateSettings.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(rebateSettings, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    // Update
    @PutMapping("/{id}")
    public ResponseEntity<RebateSetting> updateRebateSetting(@PathVariable Long id, 
                                                           @RequestBody RebateSetting rebateSetting) {
        Optional<RebateSetting> updatedSetting = updateRebateSettingService.start(id, rebateSetting);
        return updatedSetting.map(setting -> new ResponseEntity<>(setting, HttpStatus.OK))
                            .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }
    
    // Delete
    @DeleteMapping("/{id}")
    public ResponseEntity<HttpStatus> deleteRebateSetting(@PathVariable Long id) {
        try {
            boolean deleted = deleteRebateSettingService.start(id);
            if (deleted) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
```